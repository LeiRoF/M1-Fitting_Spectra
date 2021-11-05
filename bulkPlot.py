from bokeh.plotting import figure, show
import bokeh
from numpy import *

def F(w, wm, gamma, S):
    return S/pi * gamma / ((w - wm)**2 + gamma**2)

def get_data(file1, file2):

    x = []
    y = []
    yt = []
    N = 0

    with open(file1) as file:
        for line in file:
            newValues = []
            values = line.split(" ")
            for i in values:
                try:
                    newValues.append(float(i))
                except:
                    pass
            x.append(float(newValues[0]))
            y.append(float(newValues[1]))
            N += 1

    with open(file2) as file:
        for line in file:
            newValues = []
            values = line.split(" ")
            for i in values:
                try:
                    newValues.append(float(i))
                except:
                    pass
            wm = newValues[0]
            gamma = newValues[1]
            S = newValues[2]
            break

    for i in x:
        yt.append(F(i, wm, gamma, S))
    
    return x, y, yt

p = figure(title="Spectrum", sizing_mode="stretch_both", y_axis_label='Intensity (arb. unit)', x_axis_label='Wavenumber (cm-1)')
color = ["purple","blue","green","yellow","pink"]
for i in range(5):
    print(f"results/plot_spectre_{i+1}.plt")
    x, y, yt = get_data(f"results/plot_spectre_{i+1}.plt", f"results/res_spectre_{i+1}.txt")
    p.line(x, yt, legend_label=f"Fittings", line_color="red", line_width=2)
    p.circle(x, y, legend_label=f"Experimental data for spectra {i+1}", line_color=color[i], line_alpha=0.5, fill_alpha=0, size=5, line_width=1)

bokeh.io.save(p)
show(p)