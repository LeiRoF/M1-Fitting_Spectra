from bokeh.plotting import figure, show
import bokeh
from numpy import *

def F(x):
    return a*x + b

x = []
y = []
y2 = []
N = 0
with open("results/w(p)_exp.plt") as file:
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

with open("results/w(p)_theor.txt") as file:
    for line in file:
        newValues = []
        values = line.split(" ")
        for i in values:
            try:
                newValues.append(float(i))
            except:
                pass
        a = newValues[0]
        b = newValues[1]
        break

for i in x:
    y2.append(F(i))
    

p = figure(title="Spectrum", sizing_mode="stretch_both", height=800, y_axis_label='Intensity (arb. unit)', x_axis_label='Wavenumber (cm-1)')
p.circle(x, y, legend_label="Experimental data", line_color="blue", fill_alpha=0, size=12)

p.line(x, y2, legend_label="Fitting", line_color="red", line_width=2)

bokeh.io.save(p)
show(p)