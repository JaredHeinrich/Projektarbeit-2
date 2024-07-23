BENCHMARK(BM_Optimizer)
  ->Apply(BenchOptimizerArguments)
  ->Repetitions(20)
  ->Unit(benchmark::kMicrosecond);
