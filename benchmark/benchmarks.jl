using BenchmarkTools
using Plots

const SUITE = BenchmarkGroup()
julia_cmd = get(ENV, "TESTCMD", Base.JLOptions().julia_bin)

SUITE["load_plot_display"] = @benchmarkable run(`sh -c $("$julia_cmd --startup-file=no -e 'using Plots; display(plot(1:0.1:10, sin.(1:0.1:10))))'")`)
SUITE["load"] = @benchmarkable run(`sh -c $("$julia_cmd --startup-file=no -e 'using Plots'")`)
SUITE["plot"] = @benchmarkable p = plot(1:0.1:10, sin.(1:0.1:10))
SUITE["display"] = @benchmarkable display(p) setup=(p = plot(1:0.1:10, sin.(1:0.1:10)))
