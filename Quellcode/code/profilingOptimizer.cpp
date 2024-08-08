static void BM_OptimizerProfiling(benchmark::State &state)
{
  const ltt::allocator_handle allocHandle(
      ltt::allocator::global_allocator().createSubAllocator("test")
      );
  TREX_ERROR::TRexError error;
  TRexConfig::CalcEngine::JSON::Builder builder(*allocHandle);
  //erzeugt JSON-String für das (size,type)-Modell,
  //abhängig von den mitgegebenen Parametern
  CreateModel(
      builder,
      allocHandle,
      state.range(0), //size
      state.range(1) //type
      );
  Optimizer2 optimizer;
  dbgExecuteCommand("profiler clear"); //löscht Profiling-Informationen
  for (auto _ : state) {
    //erzeugt das Modell aus dem JSON-String im Builder
    RuntimeModel model(*allocHandle);
    THROW_ASSERT_0(
        FactoryAPI::jsonToRuntimeModel(model, builder.toString(), error)
        );
    dbgExecuteCommand("profiler start"); //pausiert Profiling
    optimizer.optimize(model);
    dbgExecuteCommand("profiler stop"); //setzt Profiling fort
  }
  //gibt Profiling-Informationen aus
  dbgExecuteCommand("profiler print -o /tmp/cpu.dot,/tmp/wait.dot");
}
