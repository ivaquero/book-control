#import "@local/scibook:0.1.0": *
#show: doc => conf(
  title: "控制工具箱 API",
  author: ("ivaquero"),
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)

= 模型搭建
<模型搭建>

== 常用模型
<常用模型>

#block(
  height: 12em,
  columns()[
    - 传递函数模型
      - `sys = tf(numerator,denominator)`
      - `sys = zpk(zeros,poles,gain)`
      - `sys = filt(num,den)`
    - 状态空间模型
      - `sys = ss(A,B,C,D)`
      - `sys = dss(A,B,C,D,E)`
    - 频率模型
      - `sys = frd(response,frequency)`
    - 广义模型
      - `sys = genss(sys)`
      - `sys = genfrd(sys,freqs,frequnits)`
      - `sys = ufrd(M,freqs)`
  ],
)

== PID 控制器
<pid-控制器>

#block(
  height: 5em,
  columns()[
    - `C = pid(Kp,Ki,Kd,Tf)`
    - `C = pid2(Kp,Ki,Kd,Tf,b,c)`
    - `C = pidstd(Kp,Ti,Td,N)`
    - `C = pidstd2(Kp,Ti,Td,N,b,c)`
    - `C = pidtune(sys,type)`
      - `opt = pidtuneOptions`
  ],
)


== 模型连接
<模型连接>

=== 连接方式

#block(
  height: 8em,
  columns()[
    - `sys = series(H1,H2)`
    - `sys = parallel(H1,±H2)`
    - `sys = feedback(H1,H2)`
    - `sys = inv(H1)`
    - `sys = lft(H1,H2,nu,ny)`
    - `sys = connect(sys1,...,sysN,inputs,outputs)`
    - `sys = stack(arraydim,sys1,sys2,...)`
    - `sys = blkdiag(sys1,sys2,...,sysN)`
    - `rsys = repsys(sys,[M N])`
  ],
)

=== 参数与运算

#block(
  height: 1em,
  columns()[
    - `p = realp(paramname,initvalue)`
    - `S = sumblk(formula)`
  ],
)

#pagebreak()

= 数据操作
<数据操作>

== 数据提取

#block(
  height: 7em,
  columns()[
    - `get(sys)`
    - `[num,den] = tfdata(sys)`
    - `[z,p,k] = zpkdata(sys)`
    - `[a,b,c,d] = ssdata(sys)`
    - `[A,B,C,D,E] = dssdata(sys)`
    - `[response,freq] = frdata(sys)`
    - `[Kp,Ki,Kd,Tf] = piddata(sys)`
    - `[Kp,Ti,Td,N] = pidstddata(sys)`
  ],
)

== 特征提取

#block(
  height: 8em,
  columns()[
    - `[C,X] = getComponents(C2,looptype)`
    - `H = getIOTransfer(T,in,out)`
    - `L = getLoopTransfer(T,Locations)`
    - `S = getSensitivity(T,location)`
    - `T = getCompSensitivity(CL,location)`
    - `gpeak = getPeakGain(sys)`
    - `wc = getGainCrossover(sys,gain)`
    - `response = getPIDLoopResponse(C,G,looptype)`
    - `val = getBlockValue(M,blockname)`
  ],
)

== 数据判断

#block(
  height: 8em,
  columns()[
    - 判断
      - `B = isstable(sys)`
      - `B = isproper(sys)`
      - `B = isdt(sys)`
      - `B = hasdelay(sys)`
    - 查询
      - `NS = order(sys)`
      - `[wn,zeta] = damp(sys)`
  ],
)

= 模型操作
<模型操作>

== 模型变换
<模型变换>

#block(
  height: 8em,
  columns()[
    - 单位
      - `sys = chgTimeUnit(sys,newtimeunits)`
    - 转化
      - `sysd = c2d(sysc,Ts)`
        - `opts = c2dOptions`
      - `sysc = d2c(sysd)`
        - `opts = d2cOptions`
  ],
)

== 模型简化
<模型简化>

=== 约分

#block(
  height: 3em,
  columns()[
    - `[rsys,info] = balred(sys,order)`
      - `opts = balredOptions`
    - `sysr = minreal(sys)`
    - `msys = sminreal(sys)`
  ],
)

=== 分解

#block(
  height: 1em,
  columns()[
    - `[Gs,Gf] = freqsep(G,fcut)`
    - `hsvplot(sys)`
  ],
)

=== 采样

#block(
  height: 1em,
  columns()[
    - `sys1 = d2d(sys, Ts)`
    - `sysl = upsample(sys,L)`
  ],
)

#pagebreak()

= 线性分析
<线性分析>

== 时域
<时域>

=== 数值

#block(
  height: 3em,
  columns()[
    - `AP = AnalysisPoint(name)`
    - `S = lsiminfo(y,t,yfinal)`
    - `S = stepinfo(sys)`
  ],
)

=== 可视化

#block(
  height: 5em,
  columns()[
    - `impulse(sys)`
      - `h = impulseplot(sys)`
    - `step(sys)`
      - `h = stepplot(sys)`
    - `initial(sys,x0)`
      - `h = initialplot(sys,x0)`
  ],
)

== 频域
<频域>

#block(
  height: 20em,
  columns()[
    - 数值
      - `P = pole(sys)`
      - `Z = zero(sys)`
      - `k = dcgain(sys)`
      - `fb = bandwidth(sys)`
      - `[H,wout] = freqresp(sys)`
      - `S = allmargin(L)`
    - 转换
      - `ydb = mag2db(y)`
    - 可视化
      - `pzplot(sys)`
      - `iopzplot(sys)`
      - `bode(sys)`
        - `h = bodeplot(sys)`
        - `bodemag(sys)`
        - `P = bodeoptions`
      - `margin(sys)`
      - `nyquist(sys)`
        - `h = nyquistplot(sys)`
      - `nichols(sys)`
        - `h = nicholsplot(sys)`
      - `sigma(sys)`
        - `h = sigmaplot(sys)`
      - `lsim(sys,u,t)`
  ],
)

== 无源性
<无源性>

#block(
  height: 10em,
  columns()[
    - 数值
      - `R = getPassiveIndex(G)`
      - `pf = isPassive(G)`
    - 扇区
      - `RX = getSectorIndex(H,Q)`
      - `wc = getSectorCrossover(H,Q)`
    - 可视化
      - `passiveplot(G)`
      - `sectorplot(H,Q)`
  ],
)

#pagebreak()

= 模型设计
<模型设计>

=== 子模块

#block(
  height: 4.5em,
  columns()[
    - `blk = tunablePID(name,type)`
    - `blk = tunablePID2(name,type)`
    - `blk = tunableGain(name,Ny,Nu)`
    - `blk = tunableTF(name,Nz,Np)`
    - `blk = tunableSS(name,Nx,Ny,Nu)`
  ],
)

=== 仿真设计

#block(
  height: 4.5em,
  columns()[
    - `io = getlinio(mdl)`
    - `linsys = linearize(mdl,io)`
    - `sysest = frestimate(mdl,io,input)`
    - `opspec = operspec(mdl)`
    - `op = findop(mdl,opspec)`
      - `options = findopOptions`
  ],
)

=== 其他

#block(
  height: 3.5em,
  columns()[
    - `init_config = sisoinit(config)`
    - `Msamp = sampleBlock(M,name,vals)`
    - `h = rlocusplot(sys)`
  ],
)

= 模型调参
<模型调参>

== 常规调参
<常规调参>

#block(
  height: 2.5em,
  columns()[
    - `[CL,fSoft] = systune(CL0,SoftReqs)`
      - `options = systuneOptions`
    - `[G,C,gam] = looptune(G0,C0,wc)`
  ],
)

=== 仿真设计

#block(
  height: 7.5em,
  columns()[
    - `addPoint(s,pt)`
    - `addBlock(st,blk)`
      - `value = getBlockValue(st,blk)`
      - `writeBlockValue(st)`
      - `writeLookupTableData(st,blockid,breakpoints)`
  ],
)

== 类方法
<类方法>

=== 需求

#block(
  height: 7.5em,
  columns()[
    - `TuningGoal.LQG`
    - `TuningGoal.Tracking`
      - `TuningGoal.StepTracking`
    - `TuningGoal.Rejection`
      - `TuningGoal.StepRejection`
    - `TuningGoal.Sensitivity`
    - `TuningGoal.Margins`
    - `TuningGoal.Transient`
  ],
)

=== 约束

#block(
  height: 8.5em,
  columns()[
    - `TuningGoal.Gain`
      - `TuningGoal.WeightedGain`
    - `TuningGoal.Passivity`
      - `TuningGoal.WeightedPassivity`
    - `TuningGoal.Variance`
      - `TuningGoal.WeightedVariance`
    - `TuningGoal.Poles`
      - `TuningGoal.ControllerPoles`
    - `TuningGoal.Overshoot`
  ],
)

=== 回环

#block(
  height: 3em,
  columns()[
    - `TuningGoal.LoopShape`
    - `TuningGoal.MaxLoopGain`
    - `TuningGoal.MinLoopGain`
  ],
)

== 调参器
<调参器>

- `st = slTuner(mdl,tuned_blocks)`
- `[st,fSoft] = systune(st0,SoftGoals)`
- `[st,gam,info] = looptune(st0,controls,measurements,wc)`
- `showTunable(st)`

=== 常用

#block(
  height: 4em,
  columns()[
    - `linsys = getIOTransfer(s,in,out)`
    - `linsys = getLoopTransfer(s,pt)`
    - `linsys = getSensitivity(s,pt)`
    - `linsys = getCompSensitivity(s,pt)`
  ],
)


=== 子模块

#block(
  height: 1em,
  columns()[
    - `setBlockParam(st,blk,tunable_mdl)`
    - `setBlockRateConversion(st,blk,method)`
  ],
)



== 调度
<调度>

=== 目标

- `[Hspec,fval] = evalGoal(Req,T)`
- `VG = varyingGoal(FH,par1,par2,...)`
- `viewGoal(Req)`

=== 平面

- `K = tunableSurface(name,K0init,domain,shapefcn)`
- `Knew = setData(K,Kco)`
- `GV = evalSurf(GS,X)`
- `viewSurf(GS)`


