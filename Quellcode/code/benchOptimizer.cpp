static void BM_Optimizer(benchmark::State &state)
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
  for (auto _ : state) {
    state.PauseTiming(); //pausiert Zeitmessung
    //erzeugt das Modell aus dem JSON-String im Builder
    RuntimeModel model(*allocHandle);
    THROW_ASSERT_0(
        FactoryAPI::jsonToRuntimeModel(model, builder.toString(), error)
        );
    state.ResumeTiming(); //setzt Zeitmessung fort
    optimizer.optimize(model); //führt die Optimierung aus
  }
}
