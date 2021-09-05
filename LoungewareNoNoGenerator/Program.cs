using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using System.Linq;

//place input in bin/debug/net5.0/input.txt
//output will be in bin/Debug/net5.0/output.txt

//input format:
//<func_name> <use_instead>
//<func_name> <use_instead>
//pass undefined for <use_instead> if there's not an alternative
//e.g.
//game_end undefined
//audio_play_sound sfx_play

IEnumerable<string> insteads = args.Where((val, index) => index % 2 == 1);
IEnumerable<(string Func, string Instead)> funcs = 
    File.ReadAllLines("input.txt")
        .Select(x => x.Split(" ")[0])
    .Zip(insteads);

Func<string, string> getInstead = instead
    => instead == "undefined" ? "" : $", \"{instead}\"";

IEnumerable<string> res = funcs.Select(x =>
    $"#macro {x.Func} ___throw_{x.Func}" + "\n" +
    $"#macro ___BUILTIN_{x.Func.ToUpper()} {x.Func}" + "\n" +
    $"function ___throw_{x.Func}() {{" + "\n" +
    $"\t___no_no_throw_with(\"{x.Func}\"{getInstead(x.Instead)});" + "\n" +
    $"}}");

await File.WriteAllLinesAsync("output.txt", res);




