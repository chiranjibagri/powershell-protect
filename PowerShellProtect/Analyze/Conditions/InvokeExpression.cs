using Engine;
using Engine.Configuration;
using System;
using System.Collections.Generic;
using System.Text;

namespace PowerShellProtect.Analyze.Conditions
{
    internal class InvokeExpression : ICondition
    {
        public string Name => "InvokeExpression";

        public string Description => "Invoke-Expression is often used to execute malicious payloads downloaded from the internet.";

        public bool Analyze(ScriptContext context, Condition condition)
        {
            return context.Commands.Contains("invoke-expression") || context.Commands.Contains("iex");
        }
    }
}
