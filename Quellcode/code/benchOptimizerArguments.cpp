static void BenchOptimizerArguments(benchmark::internal::Benchmark* b) {
  for (int type : {
      modelCreationJoinAggrProj,
      modelCreationJoinWithFilter,
      modelCreationJoinWithoutFilter,
      modelCreationProjMapping,
      modelCreationProjRemovingColumns
      }) {
    for (int size : {
        8,16,32,64,128,256,512,1024,2048
        }) {
      b->Args({size, type});
    }
  }
}
