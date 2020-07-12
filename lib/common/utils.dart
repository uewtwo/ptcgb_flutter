/// utilities

List<String> getGenerationOrders() => ['sa', 'sm'];

String getGenerationDisplayName(String gen) {
  final _map = {'sa': 'ソード＆シールド', 'sm': 'サン＆ムーン'};
  return _map[gen];
}
