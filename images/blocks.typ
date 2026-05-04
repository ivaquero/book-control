#import "@local/consketcher:0.1.0": *
#import "@preview/fletcher:0.5.8": edge

#let feedback = figure(
  control-diagram(
    let (upper, lower) = (-.5, 1.5),
    let far = 3,
    let (left, mid, right) = (-far, 0, far),
    let U = (left, upper),
    let X = (right, upper),

    let F1 = (left, 0),
    let F11 = (left - far, 0),
    let F2 = (right, 0),
    let F22 = (right + far, 0),

    let F = (mid, 0),
    let Phi = (mid, lower),

    rnode(
      F,
      $f(x, u)$,
      width: 8em,
      height: 4em,
    ),
    rnode(
      Phi,
      $phi(x)$,
      width: 8em,
      height: 4em,
    ),

    arrow(F11, F, $u$),
    arrow(F, F22, $x$),

    edge(
      F2,
      (X.at(0), Phi.at(1)),
      Phi,
      marks: "-|>",
      corner: right,
    ),
    edge(
      Phi,
      (U.at(0), Phi.at(1)),
      F1,
      marks: "-|>",
      corner: right,
    ),
  ),
  caption: "反馈",
)

#let freqres = figure(
  control-diagram(
    let far = 3.5,
    let lower = 2,
    let (left, mid1, mid2, right) = (0, 2.5, 4.5, 7),
    let S1 = (left, 0),
    let I = (left - far, 0),
    let C = (mid1, 0),
    let G = (mid2, 0),
    let S2 = (right, 0),
    let O = (right + far, 0),
    let S3 = ((mid1 + mid2) / 2, lower),
    let N = ((mid1 + mid2) / 2, lower * 1.5),
    let D = (right, -lower * 0.5),

    arrow(I, S1, $R(s)$),

    reference(
      S1,
      x-offset: -.3,
      y-offset: .3,
      node-maker: onode.with(radius: 1.5em),
    ),

    rnode(
      C,
      $C(s)$,
      width: 6em,
      height: 3em,
    ),
    rnode(
      G,
      $G(s)$,
      width: 6em,
      height: 3em,
    ),

    reference(
      S2,
      y-sign: "+",
      x-offset: -.3,
      y-offset: -.3,
      node-maker: onode.with(radius: 1.5em),
    ),

    reference(
      S3,
      y-sign: "+",
      x-offset: .22,
      y-offset: .3,
      node-maker: onode.with(radius: 1.5em),
    ),


    arrow(S1, C, none),
    arrow(C, G, none),
    arrow(G, S2, none),
    arrow(S2, O, $X(s)$),

    edge(
      S2,
      (S2.at(0), S3.at(1)),
      S3,
      marks: "-|>",
      corner: right,
    ),

    label(N, $N(s)$),
    edge(
      N,
      S3,
      marks: "-|>",
    ),

    label(D, $D(s)$),
    edge(
      D,
      S2,
      marks: "-|>",
    ),

    edge(
      S3,
      (S1.at(0), S3.at(1)),
      S1,
      marks: "-|>",
      corner: right,
    ),
  ),
  caption: "带有扰动和噪声的闭环控制系统",
)

#let closed-one = figure(
  closed-loop-block($G(s)$),
  caption: "闭环控制",
)

#let closed-two = figure(
  closed-loop-block(
    $
      frac(1, s (s + 2))
    $,
  ),
  caption: "闭环系统",
)

#let compens-lead = figure(
  compensated-loop-block(
    $s + 8$,
    $K$,
    $
      frac(1, s (s + 2))
    $,
  ),
  caption: "PD 控制",
)

#let compens-lag = figure(
  compensated-loop-block(
    $K$,
    $
      frac(s + z, s + p)
    $,
    $
      frac(1, s (s + 2))
    $,
    first-width: 2em,
    second-width: 5em,
  ),
  caption: "closed-lag",
)

#let prop-simple = figure(
  control-diagram(
    let far = 2,
    let lower = 1.5,
    let (mid1, mid2, mid3) = (3, 6, 8),
    let (I, R, K, G, X, O) = (
      (-far, 0),
      (0, 0),
      (mid1, 0),
      (mid2, 0),
      (mid3, 0),
      (mid3 + far, 0),
    ),
    let (F1, F2) = (
      (X.at(0), lower),
      (R.at(0), lower),
    ),

    reference(
      R,
      x-offset: -0.3,
      y-offset: 0.3,
      node-maker: onode.with(radius: 1.5em),
    ),

    rnode(K, $k_p$, width: 4em, height: 3em),
    rnode(
      G,
      $
        frac(1, a s + 1)
      $,
      width: 6em,
      height: 3em,
    ),

    arrow(I, R, $R(s)$),
    arrow(R, K, none),
    arrow(K, G, none),
    arrow(G, O, $X(s)$),

    edge(
      X,
      F1,
      F2,
      R,
      marks: "-|>",
      corner: right,
    ),
  ),
  caption: "弹簧阻尼系统框图",
)

#let prop = figure(
  control-diagram(
    let far = 2,
    let upper = -1.25,
    let lower = 1.5,
    let (mid1, mid2, mid3, mid4) = (2.5, 5, 7.5, 9.5),
    let (I, E, C, D, P, X, O) = (
      (-far, 0),
      (0, 0),
      (mid1, 0),
      (mid2, 0),
      (mid3, 0),
      (mid4, 0),
      (mid4 + far, 0),
    ),
    let Disturbance = (D.at(0), upper),
    let (F1, F2) = (
      (X.at(0), lower),
      (E.at(0), lower),
    ),

    reference(
      E,
      x-offset: -0.3,
      y-offset: 0.3,
      node-maker: onode.with(radius: 1.5em),
    ),

    rnode(C, $k_p$, width: 3em, height: 3em),

    reference(
      D,
      y-sign: "+",
      x-offset: -0.28,
      y-offset: -0.28,
      node-maker: onode.with(radius: 1.5em),
    ),

    rnode(
      P,
      $
        frac(1, 7000 s + 10 alpha)
      $,
      width: 7em,
      height: 3em,
    ),

    arrow(I, E, $R(s)$),
    arrow(E, C, $E$),
    arrow(C, D, $U(s)$),
    arrow(D, P, none),
    arrow(P, O, $M(s)$),
    arrow(Disturbance, D, $D(s)$),

    edge(
      X,
      F1,
      F2,
      E,
      marks: "-|>",
      corner: right,
    ),
  ),
  caption: "比例控制",
)

#let pid = figure(
  control-diagram(
    let far = 2,
    let branch = 1.5,
    let (top, mid, bottom) = (-1.2, 0, 1.2),
    let (I, E, B, P, I2, D, S, G, O) = (
      (-far, 0),
      (0, 0),
      (branch, 0),
      (3, top),
      (3, mid),
      (3, bottom),
      (5, 0),
      (7, 0),
      (9, 0),
    ),

    reference(
      E,
      x-offset: -0.3,
      y-offset: 0.25,
      node-maker: onode.with(radius: 1.5em),
    ),

    rnode(
      P,
      $k_p$,
      width: 4em,
      height: 3em,
    ),
    rnode(
      I2,
      $
        k_I frac(1, s)
      $,
      width: 4em,
      height: 3em,
    ),
    rnode(
      D,
      $k_D s$,
      width: 4em,
      height: 3em,
    ),

    reference3(S, radius: 1.5em),

    rnode(
      G,
      ctext("系统"),
      width: 4em,
      height: 2em,
    ),

    arrow(I, E, $r$),
    arrow(E, B, $e$),
    arrow(B, I2, none),
    arrow(I2, S, none),
    arrow(S, G, none),
    arrow(G, O, $x$),

    arrow((B.at(0), top), P, none),
    arrow((B.at(0), bottom), D, none),
    segment((B.at(0), top), (B.at(0), bottom), none),

    edge(
      P,
      (S.at(0), top),
      S,
      marks: "-|>",
      corner: right,
    ),
    edge(
      D,
      (S.at(0), bottom),
      S,
      marks: "-|>",
      corner: right,
    ),

    let fo = (8, 0),
    let fm = (3, lower + 1),
    let fmi = (0, lower + 1),
    let fmo = (8, lower + 1),
    edge(
      fo,
      fmo,
      fm,
      fmi,
      E,
      marks: "-|>",
      corner: right,
      kind: "poly",
    ),
  ),
  caption: "PID 控制器",
)

#let sensor = figure(
  control-diagram(
    let far = 2,
    let lower = 2,
    let (mid1, mid2, mid3) = (2, 3.5, 5),
    let (I, R, C, G, X, O) = (
      (-far, 0),
      (0, 0),
      (mid1, 0),
      (mid2, 0),
      (mid3, 0),
      (mid3 + far, 0),
    ),
    let H = ((C.at(0) + G.at(0)) / 2, lower),
    let (F1, F2) = (
      (X.at(0), lower),
      (R.at(0), lower),
    ),

    reference(
      R,
      x-offset: -0.3,
      y-offset: 0.3,
      node-maker: onode.with(radius: 1.5em),
    ),

    label((C.at(0), C.at(1) - .65), ctext("控制器")),
    rnode(
      C,
      $
        K frac(s + 0.1, s + 0.01)
      $,
      width: 6em,
      height: 3em,
    ),

    label((G.at(0), G.at(1) - .65), ctext("系统")),
    rnode(
      G,
      $
        frac(1, s^2 + 0.4 s + 1)
      $,
      width: 7em,
      height: 3em,
    ),

    label((H.at(0), H.at(1) - .65), ctext("传感器")),
    rnode(
      H,
      $
        frac(1, s + 5)
      $,
      width: 6em,
      height: 3em,
    ),

    arrow(I, R, $R(s)$),
    arrow(R, C, none),
    arrow(C, G, none),
    arrow(G, O, $X(s)$),
    edge(
      X,
      F1,
      H,
      marks: "-|>",
      corner: right,
      kind: "poly",
    ),
    edge(
      H,
      F2,
      R,
      marks: "-|>",
      corner: right,
      kind: "poly",
    ),
    label(((C.at(0) + G.at(0)) / 2, upper), $G(s)$),
    dashed-box((C, G), inset: 1.5em),
    label(((C.at(0) + G.at(0)) / 2, lower + 1), $H(s)$),
    dashed-box((H,), inset: 1.5em),
  ),
  caption: "传感器",
)

#let lqr-trk-const = figure(
  control-diagram(
    let lower = 2,
    let (left, mid1, mid2, right) = (1.5, 2, 3, 4),
    let (U, G, F, X) = (
      (left, lower),
      (mid1, 0),
      (mid2, lower),
      (right, lower / 2),
    ),
    let (Dsrc, Usplit) = (
      (right + 1.2, 1),
      (left - 1.5, lower),
    ),

    formula-node(
      G,
      $
        x_([k+1]) + A x_([k]) + B u_([k])
      $,
      width: 10em,
      height: 3em,
    ),
    formula-node(
      X,
      $
        x_(a[k])
      $,
      width: 4em,
      height: 2em,
    ),
    formula-node(
      U,
      $
        u_([k]) = u_d + delta u_([k])
      $,
      width: 8em,
      height: 3em,
    ),

    gain-node(
      F,
      $-F$,
      width: 2.5em,
      height: 2.5em,
    ),

    label(
      (mid1 - .8, -0.5),
      $u_([k])$,
    ),
    label(
      (mid2, -0.5),
      $x_([k+1])$,
    ),
    arrow((mid2, 0), (mid2 + 2, 0), none),
    label(
      (mid1 + 0.5, lower * 0.8),
      $delta^* u_([k])$,
    ),
    label(
      (right + .75, lower * 0.7),
      $x_d$,
    ),

    edge(G, (X.at(0), 0), X, marks: "-|>", corner: right),
    edge(Dsrc, X, marks: "-|>"),
    edge(X, (X.at(0), F.at(1)), F, marks: "-|>", corner: right),
    arrow(F, U, none),
    edge(
      U,
      Usplit,
      (Usplit.at(0), G.at(1)),
      G,
      marks: "-|>",
      corner: right,
    ),
  ),
  caption: "轨迹追踪 LQR 系统",
)

#let lqr-trk-var = figure(
  control-diagram(
    let lower = 2,
    let (left, mid1, mid2, right) = (1.5, 2, 3, 4),
    let (U, G, F, X) = (
      (left, lower),
      (mid1, 0),
      (mid2, lower),
      (right, lower / 2),
    ),
    let (Dsrc, Usplit) = (
      (right + 1.2, 1),
      (left - 1.5, lower),
    ),

    formula-node(
      G,
      $
        x_([k+1]) + A x_([k]) + B u_([k])
      $,
      width: 10em,
      height: 3em,
    ),
    formula-node(
      X,
      $
        x_(a[k])
      $,
      width: 4em,
      height: 2em,
    ),
    formula-node(
      U,
      $
        u_([k]) = u_([k-1]) + delta u_([k])
      $,
      width: 10em,
      height: 3em,
    ),

    gain-node(
      F,
      $-F$,
      width: 2.5em,
      height: 2.5em,
    ),

    label(
      (mid1 - .8, -0.5),
      $u_([k])$,
    ),
    label(
      (mid2, -0.5),
      $x_([k+1])$,
    ),
    label(
      (mid1 + 0.5, lower * 0.8),
      $delta^* u_([k])$,
    ),

    let I1 = (right + .75, lower * 1.2),
    label(
      I1,
      $x_(d[k+1]) = A_D x_(d[k])$,
    ),
    let I2 = (right + .75, lower * 0.6),
    label(
      I2,
      $x_(d[k])$,
    ),

    edge(G, (X.at(0), 0), X, marks: "-|>", corner: right),
    arrow((X.at(0), 0), (I1.at(0), 0), none),

    edge(Dsrc, X, marks: "-|>"),
    edge(X, (X.at(0), F.at(1)), F, marks: "-|>", corner: right),
    arrow(F, U, none),
    edge(
      U,
      Usplit,
      (Usplit.at(0), G.at(1)),
      G,
      marks: "-|>",
      corner: right,
    ),
    arrow(I1, I2, none),
  ),
  caption: "稳态非零矩阵输入",
)
