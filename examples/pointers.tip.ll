; ModuleID = '../../tip/examples/pointers.tip.bc'
source_filename = "../../tip/examples/pointers.tip"

@_tip_ftable = internal dso_local constant [1 x i64 ()*] [i64 ()* @_tip_main]
@_tip_num_inputs = constant i64 0
@_tip_input_array = common global [0 x i64] zeroinitializer

; Function Attrs: nounwind readnone
declare void @llvm.donothing() #0

define i64 @_tip_main() {
entry:
  %pb = alloca i64
  %pa = alloca i64
  %x = alloca i64
  store i64 0, i64* %x
  store i64 0, i64* %pa
  store i64 0, i64* %pb
  store i64 5, i64* %x
  %intPtrVal = ptrtoint i64* %x to i64
  store i64 %intPtrVal, i64* %pa
  %pa1 = load i64, i64* %pa
  store i64 %pa1, i64* %pb
  %pb2 = load i64, i64* %pb
  %ptrIntVal = inttoptr i64 %pb2 to i64*
  store i64 2, i64* %ptrIntVal
  %x3 = load i64, i64* %x
  %eqtmp = icmp eq i64 %x3, 2
  ret i1 %eqtmp
}

attributes #0 = { nounwind readnone }
