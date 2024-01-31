import lldb
from lldb import SBModule, SBCompileUnit, SBLineEntry
from functools import wraps
from collections import defaultdict


def command(func):
    lldb.debugger.HandleCommand(f"command script add -f {func.__name__} {func.__name__}")
    return func


def iter_to_list(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        return list(func(*args, **kwargs))
    return wrapper


def get_debug_info():
    m: SBModule = lldb.target.module[0]
    res = defaultdict(set)
    for i in range(m.GetNumCompileUnits()):
        cu: SBCompileUnit = m.GetCompileUnitAtIndex(i)
        for j in range(cu.num_line_entries):
            le: SBLineEntry = cu.GetLineEntryAtIndex(j)
            res[le.file.fullpath].add((le.line, le.column))
    return res


print("LLDBINIT GOooood")


