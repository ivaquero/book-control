#import "@preview/qooklet:0.2.1": *
#import "@preview/subpar:0.2.2": grid as sgrid
#import "@preview/rexllent:0.3.0": xlsx-parser
// control sketch
#import "@preview/consketcher:0.1.0": *
#import "@preview/lilaq:0.2.0" as lq
#import "@preview/tiptoe:0.3.0"

#let peak(value, distance) = value > 0 and distance < 5pt

#let trans-linear(
  x,
  y,
  y2,
  ylim-base,
  caption: none,
  width: 100pt,
  column: 60pt,
  gutter: 50pt,
) = sgrid(
  figure(
    lq.diagram(
      width: width,
      height: width * .5,
      lq.plot(x, y, mark: none),
      xlim: (x.at(0), x.at(-1)),
      ylim: (ylim-base.at(0), ylim-base.at(-1) + ylim-base.at(-1) / 10),
      xaxis: (position: 0, tip: none, ticks: none),
      yaxis: (position: 0, tip: none, filter: peak),
    ),
  ),
  figure(
    lq.diagram(
      width: width,
      height: width * .5,
      lq.place(x.at(-1) * .5, y.at(-1) * .5)[$h(x)$],
      lq.rect(
        x.at(-1) * .3,
        y.at(-1) * .3,
        width: x.at(-1) * .4,
        height: y.at(-1) * .4,
      ),
      lq.line(
        tip: tiptoe.stealth,
        (x.at(-1) * .7, y.at(-1) * .5),
        (x.at(-1) * .9, y.at(-1) * .5),
      ),
      lq.line(
        tip: tiptoe.stealth,
        (x.at(-1) * .1, y.at(-1) * .5),
        (x.at(-1) * .3, y.at(-1) * .5),
      ),
      xlim: (x.at(0), x.at(-1)),
      ylim: (y.at(0), y.at(-1) + y.at(-1) / 10),
      xaxis: (stroke: none, ticks: none),
      yaxis: (stroke: none, ticks: none),
    ),
  ),
  figure(
    lq.diagram(
      width: width,
      height: width * .5,
      lq.plot(x, y2, mark: none),
      xlim: (x.at(0), x.at(-1)),
      ylim: (ylim-base.at(0), ylim-base.at(-1) + ylim-base.at(-1) / 10),
      xaxis: (position: 0, tip: none, ticks: none),
      yaxis: (position: 0, tip: none, filter: peak),
    ),
  ),
  columns: (column,) * 3,
  gutter: gutter,
  caption: caption,
)
