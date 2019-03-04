WandererSymbol(x...) = Symbol(join(["Wanderer", x...], "."))

ARG = WandererSymbol("ARG") # we just need limited mangled symbols here.
TYPE_ROOT = WandererSymbol("TYPE_ROOT")

IN_TYPES = WandererSymbol("IN", "TYPES")
IN_FIELDS = WandererSymbol("IN", "FIELDS")
IN_SOURCE = WandererSymbol("IN", "SOURCE")

OUT_TYPES = WandererSymbol("OUT", "TYPES")
OUT_FIELDS = WandererSymbol("Wanderer", "OUT.FIELDS")
OUT_SOURCE = WandererSymbol("Wanderer", "OUT.SOURCE")
RECORD = WandererSymbol("RECORD")

N = WandererSymbol("N")
GROUPS = WandererSymbol("GROUPS")
GROUP_KEY = WandererSymbol("GROUP_KEY")

FN = WandererSymbol("FN")
FN_RETURN_TYPES = WandererSymbol("FN", "RETURN_TYPES")
FN_OUT_FIELDS = WandererSymbol("FN", "OUT_FIELDS")

AGG = WandererSymbol("AGG")
AGG_TYPES = WandererSymbol("AGG", "TYPES")

_gen_sym_count = 0
function gen_sym()
    global _gen_sym_count
    let sym = WandererSymbol("TMP", _gen_sym_count)
        _gen_sym_count = _gen_sym_count  + 1
        sym
    end
end

function gen_sym(a :: Union{Symbol, Int, String})
    global _gen_sym_count
    WandererSymbol("Symbol", a)
end