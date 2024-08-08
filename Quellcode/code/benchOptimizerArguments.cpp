enum class ModelTypes {
  PROJECTION = 0,
  JOIN = 1,
  UNION = 2,
};

static void BenchOptimizerArguments(benchmark::internal::Benchmark *b)
{
  for (int type : {
      static_cast<int>(ModelTypes::PROJECTION),
      static_cast<int>(ModelTypes::JOIN),
      static_cast<int>(ModelTypes::UNION),
      }) {
    for (int size : {8, 16, 32, 64, 128, 256, 512, 1024, 1536, 2048}) {
      //fügt {size,type} den Parameterpaaren des Benchmarks hinzu
      b->Args({size, type});
    }
  }
}
