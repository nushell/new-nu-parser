pub trait Command: CommandClone {
    fn name(&self) -> &str;
}

#[derive(Clone)]
pub struct Declaration {
    name: String,
}

impl Declaration {
    pub fn new(name: String) -> Self {
        Self { name }
    }
}

impl Command for Declaration {
    fn name(&self) -> &str {
        &self.name
    }
}

// Cloning implementation taken from Nushell
pub trait CommandClone {
    fn clone_box(&self) -> Box<dyn Command>;
}

impl<T> CommandClone for T
where
    T: 'static + Command + Clone,
{
    fn clone_box(&self) -> Box<dyn Command> {
        Box::new(self.clone())
    }
}

impl Clone for Box<dyn Command> {
    fn clone(&self) -> Box<dyn Command> {
        self.clone_box()
    }
}
