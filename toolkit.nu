# Prints input string with highlighted span
#
# Useful for debugging parser output
export def span [span_start: int, span_end: int]: string -> nothing {
    let s = $in | encode utf8

    let pre = $s | bytes at ..($span_start - 1) | decode
    let highlighted = $s | bytes at $span_start..($span_end - 1) | decode
    let post = $s | bytes at ($span_end).. | decode

    print ($pre + $'(ansi ru)($highlighted)(ansi reset)' + $post)
}

# Runs the parser on all nu scripts for given list of files and directories.
# When directory is passed, all *.nu scripts are found recursively.
#
# Returns a table with a row for every file that was parsed, the exit_code of
# the parser and the time it took to parse the source.
#
# Example usage:
# $ parse-all example.nu ../nu_scripts/
export def parse-all [
    --verbose (-v)=false # Print the file name before parsing (useful when parser hangs)
     ...sources: string # The list of nu scripts and directories to parse
 ] -> list<record<file: string, exit_code: int, time: duration>> {
    let files = $sources | each { |$source| 
        if ($source | path type) == "dir" {
            glob ($source | path join "**/*.nu") 
        } else {
            [$source]
        }
    } | flatten
    $files | each { |file| 
        if $verbose {
            print $"Analyzing ($file) ..."
        }
        mut output = {}
        let time = timeit {
            let ret = (./target/debug/new-nu-parser $file | complete)
            $output = $ret
        }
        {
            file: $file,
            exit_code: $output.exit_code
            time: $time,
        }
    }
}

# Summarizes the output produced by `parse-all` command.
#
# Example usage:
# $ summary (parse-all ../nu_scripts/)
export def summary [report: list<record<file: string, exit_code: int, time: duration>>] {
    let errors = $report | where exit_code == 1
    let crashes = $report | where exit_code != 0 and exit_code != 1
    let slowest = $report | sort-by time | last

    print $"Total files: ($report | length)"
    print $"Errors: ($report | where exit_code == 1 | length)"
    print $"Crashes: ($report | where exit_code != 1 and exit_code != 0 | length)"
    print $"Successes: ($report | where exit_code == 0 | length)"
    if ($errors | length) > 0 {
        print $"Sample error file: ($errors | first | get file)"
    }
    if ($crashes | length) > 0 {
        print $"Sample crash file: ($crashes | first | get file)"
    }
    print $"Slowest file: ($slowest | get time) ($slowest | get file)"
}
