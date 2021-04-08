class ChartState {}

class ChartInitState extends ChartState {}

class ChartLoading extends ChartState {}

class ChartLoaded extends ChartState {
  final Map state;
  ChartLoaded({this.state});
}
