using System.Collections.Generic;
using System.Linq;

namespace Engine.Configuration
{
    public class Configuration
    {
        public List<Rule> Rules { get; set; }
        public List<Action> Actions { get; set; }
        public BuiltIn BuiltIn { get; set;  }
    }

    public class BuiltIn
    {
        public bool Enabled { get; set; }
        public List<ActionRef> Actions { get; set; }
    }

    public class Rule
    {
        public string Name { get; set; }
        public List<Condition> Conditions { get; set; }
        public List<ActionRef> Actions { get; set; }
    }

    public class Condition
    {
        public string Property { get; set; }
        public string Operator { get; set; }
        public string Value { get; set; }
    }

    public class ActionRef
    {
        public string Name { get; set; }
    }

    public class Action
    {
        public string Name { get; set; }
        public string Type { get; set; }
        public List<Setting> Settings { get; set; }

        public string GetSetting(string name)
        {
            return Settings.FirstOrDefault(m => m.Name.Equals(name, System.StringComparison.OrdinalIgnoreCase))?.Value;
        }
    }

    public class Setting
    {
        public string Name { get; set; }
        public string Value { get; set; }
    }
        
}
