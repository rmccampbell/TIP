; ModuleID = '../../tip/examples/ptr1.tip.bc'
source_filename = "../../tip/examples/ptr1.tip"

@_tip_ftable = internal dso_local constant [1 x i64 ()*] [i64 ()* bitcast (i64 (i64)* @test to i64 ()*)]
@_tip_num_inputs = constant i64 0
@_tip_input_array = common global [0 x i64] zeroinitializer

; Function Attrs: nounwind readnone
declare void @llvm.donothing() #0

define i64 @test(i64 %p) {
entry:
  %q = alloca i64
  %p1 = alloca i64
  store i64 %p, i64* %p1
  store i64 0, i64* %q
  store i64 3, i64* %q
  %p2 = load i64, i64* %p1
  %ptrIntVal = inttoptr i64 %p2 to i64*
  %valueAt = load i64, i64* %ptrIntVal
  ret i64 %valueAt
}

define i64 @_tip_main() {
entry:
  call void @_tip_main_undefined()
  ret i64 0
}

declare void @_tip_main_undefined()

attributes #0 = { nounwind readnone }
