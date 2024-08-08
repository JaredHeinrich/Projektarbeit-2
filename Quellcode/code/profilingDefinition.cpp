BENCHMARK(BM_Optimizer_Profiling)
  ->Args({2048,modelCreationJoinWithFilter})
  ->Unit(benchmark::kMicrosecond);
