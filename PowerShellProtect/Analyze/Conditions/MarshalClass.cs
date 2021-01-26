﻿using Engine;
using Engine.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation.Language;
using System.Text;

namespace PowerShellProtect.Analyze.Conditions
{
    internal class MarshalClass : ICondition
    {
        public string Name => "MarshalClass";

        public string Description => "An attempt was made to use the Marshal class. The Marshal class is for working with unmanaged memory.";

        public bool Analyze(ScriptContext context, Condition condition)
        {
            return context.Ast.FindAll(m => m is TypeExpressionAst ast && ast.TypeName.FullName.ToLower().Contains("marshal"), true).Any();
        }
    }
}
