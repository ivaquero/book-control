#import "@preview/patatrac:0.5.0"

#let vibration = figure(
  patatrac.cetz.canvas(length: 5mm, {
    import patatrac: *
    import cetz.draw: content

    let draw = cetz.standard(
      spring: (radius: 0.5, pitch: 0.5),
    )
    let (t, b) = (4.5, 1.5)
    let (l, m, r) = (0, 4, 9.5)

    let W = rect(.1, 6)
    let M = rect(5, 5)
    let B = rect(1, 2)
    let F = arrow((r + 5, (t + b) / 2, -90deg), 3)
    let x = arrow((r + .5, t + 2, -90deg), 3)
    let WX = rect(.01, 1.5)

    let W = slide(W("c"), 0, (t + b) / 2)
    let A = slide(M("c"), 12, (t + b) / 2)
    let B = slide(B("c"), t, b)
    let WX = slide(WX("c"), r + 0.5, t + 2)

    let k = spring((l, t), (r, t))
    let s1 = rope((l, b), (m, b))
    let s2 = rope((m + 1, b), (r, b))

    content((m + .5, b), [B])
    content((m + .5, t + 1.5), [K])
    content((r + 2.5, (t + b) / 2), [#text("m", size: 16pt)])
    content((r + 6.5, (t + b) / 1.5), [#text("F", size: 14pt)])
    content((r + 2, t + 3), [#text("x", size: 14pt)])

    draw(k)
    draw(W, fill: black)
    draw(A)
    draw(B)
    draw(F)
    draw(x)
    draw(WX)
    draw(s1)
    draw(s2)
  }),
  caption: "弹簧振动阻尼系统",
)

#let vibration-nl = figure(
  patatrac.cetz.canvas(length: 5mm, {
    import patatrac: *
    import cetz.draw: content

    let draw = cetz.standard(
      spring: (radius: 0.5, pitch: 0.5),
    )
    let (t, b) = (3, 1.5)
    let (l, m, r) = (0, 4, 8)

    let W = rect(.1, 3)
    let M = rect(3, 3)
    let F = arrow((r + 3, (t + b) / 2, -90deg), 2.5)
    let WX = rect(.01, 1)
    let x = arrow((r + 1, t + 1.5, -90deg), 2)

    let W = slide(W("c"), 0, (t + b) / 2)
    let M = slide(M("c"), 9.5, (t + b) / 2)
    let WX = slide(WX("c"), r + 1, t + 1.5)

    let k = spring((l, (t + b) / 2), (r, (t + b) / 2))

    content((m + .5, t + 1.5), [#text("α", size: 16pt)])
    content((r + 1.5, (t + b) / 2), [#text("m", size: 16pt)])
    content((r + 6, (t + b) / 2), [#text("F", size: 14pt)])
    content((r + 1.8, t + 2.5), [#text("x", size: 14pt)])

    draw(k)
    draw(W, fill: black)
    draw(M)
    draw(F)
    draw(x)
    draw(WX)
  }),
  caption: "非线性弹簧系统",
)
