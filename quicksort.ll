target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@first_format = private constant [5 x i8] c"%d  \00", align 1
@second_format = private constant [2 x i8] c"\0A\00", align 1

@unsorted_array = private constant [7 x i32] [i32 8, i32 7, i32 2, i32 1, i32 0, i32 9, i32 6], align 4
@unsorted_array_display = private constant [16 x i8] c"Unsorted Array\0A\00", align 1
@sorted_array_display = private constant [16 x i8] c"Sorted array: \0A\00", align 1

define void @swap(ptr %0, ptr %1)  {
  %3 = alloca ptr, align 4
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store ptr %1, ptr %4, align 4
  %6 = load ptr, ptr %3, align 4
  %7 = load i32, ptr %6, align 4
  store i32 %7, ptr %5, align 4
  %8 = load ptr, ptr %4, align 4
  %9 = load i32, ptr %8, align 4
  %10 = load ptr, ptr %3, align 4
  store i32 %9, ptr %10, align 4
  %11 = load i32, ptr %5, align 4
  %12 = load ptr, ptr %4, align 4
  store i32 %11, ptr %12, align 4
  ret void
}

define i32 @partition(ptr %0, i32 %1, i32 %2)  {
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %10 = load ptr, ptr %4, align 4
  %11 = load i32, ptr %6, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds i32, ptr %10, i64 %12
  %14 = load i32, ptr %13, align 4
  store i32 %14, ptr %7, align 4
  %15 = load i32, ptr %5, align 4
  %16 = sub nsw i32 %15, 1
  store i32 %16, ptr %8, align 4
  %17 = load i32, ptr %5, align 4
  store i32 %17, ptr %9, align 4
  br label %18

18:                                        
  %19 = load i32, ptr %9, align 4
  %20 = load i32, ptr %6, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %45

22:                                             
  %23 = load ptr, ptr %4, align 4
  %24 = load i32, ptr %9, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i32, ptr %23, i64 %25
  %27 = load i32, ptr %26, align 4
  %28 = load i32, ptr %7, align 4
  %29 = icmp sle i32 %27, %28
  br i1 %29, label %30, label %41

30:                                              
  %31 = load i32, ptr %8, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %8, align 4
  %33 = load ptr, ptr %4, align 4
  %34 = load i32, ptr %8, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds i32, ptr %33, i64 %35
  %37 = load ptr, ptr %4, align 4
  %38 = load i32, ptr %9, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds i32, ptr %37, i64 %39
  call void @swap(ptr %36, ptr %40)
  br label %41

41:                                              
  br label %42

42:                                             
  %43 = load i32, ptr %9, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %9, align 4
  br label %18

45:                                               
  %46 = load ptr, ptr %4, align 4
  %47 = load i32, ptr %8, align 4
  %48 = add nsw i32 %47, 1
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds i32, ptr %46, i64 %49
  %51 = load ptr, ptr %4, align 4
  %52 = load i32, ptr %6, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds i32, ptr %51, i64 %53
  call void @swap(ptr %50, ptr %54)
  %55 = load i32, ptr %8, align 4
  %56 = add nsw i32 %55, 1
  ret i32 %56
}

define void @quickSort(ptr  %0, i32 %1, i32 %2) {
  %4 = alloca ptr, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %8 = load i32, ptr %5, align 4
  %9 = load i32, ptr %6, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %24

11:                                               ; preds = %3
  %12 = load ptr, ptr %4, align 4
  %13 = load i32, ptr %5, align 4
  %14 = load i32, ptr %6, align 4
  %15 = call i32 @partition(ptr %12, i32 %13, i32 %14)
  store i32 %15, ptr %7, align 4
  %16 = load ptr, ptr %4, align 4
  %17 = load i32, ptr %5, align 4
  %18 = load i32, ptr %7, align 4
  %19 = sub nsw i32 %18, 1
  call void @quickSort(ptr %16, i32  %17, i32 %19)
  %20 = load ptr, ptr %4, align 4
  %21 = load i32, ptr %7, align 4
  %22 = add nsw i32 %21, 1
  %23 = load i32, ptr %6, align 4
  call void @quickSort(ptr %20, i32 %22, i32 %23)
  br label %24

24:                                           
  ret void
}

define void @printArray(ptr %0, i32 %1) {
  %3 = alloca ptr, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  br label %6

6:                                                
  %7 = load i32, ptr %5, align 4
  %8 = load i32, ptr %4, align 4
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %20

10:                                             
  %11 = load ptr, ptr %3, align 4
  %12 = load i32, ptr %5, align 4
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds i32, ptr %11, i64 %13
  %15 = load i32, ptr %14, align 4
  %16 = call i32 (ptr, ...) @printf(ptr @first_format, i32 %15)
  br label %17

17:                                               
  %18 = load i32, ptr %5, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, ptr %5, align 4
  br label %6

20:                                               
  %21 = call i32 (ptr, ...) @printf(ptr @second_format)
  ret void
}

declare i32 @printf(ptr, ...)
declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)

define i32 @main() {
  %1 = alloca [7 x i32], align 4
  %2 = alloca i32, align 4
  call void @llvm.memcpy.p0.p0.i64(ptr align 4 %1, ptr align 4 @unsorted_array, i64 28, i1 false)
  store i32 7, ptr %2, align 4
  %3 = call i32 (ptr, ...) @printf(ptr @unsorted_array_display)
  %4 = getelementptr inbounds [7 x i32], ptr %1, i64 0, i64 0
  %5 = load i32, ptr %2, align 4
  call void @printArray(ptr %4, i32 %5)
  %6 = getelementptr inbounds [7 x i32], ptr %1, i64 0, i64 0
  %7 = load i32, ptr %2, align 4
  %8 = sub nsw i32 %7, 1
  call void @quickSort(ptr %6, i32 0, i32 %8)
  %9 = call i32 (ptr, ...) @printf(ptr @sorted_array_display)
  %10 = getelementptr inbounds [7 x i32], ptr %1, i64 0, i64 0
  %11 = load i32, ptr %2, align 4
  call void @printArray(ptr %10, i32 %11)
  ret i32 0
}