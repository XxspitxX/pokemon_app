enum PokeType {
  normal(1),
  fighting(2),
  flying(3),
  poison(4),
  ground(5),
  rock(6),
  bug(7),
  ghost(8),
  steel(9),
  fire(10),
  water(11),
  grass(12),
  electric(13),
  psychic(14),
  ice(15),
  dragon(16),
  dark(17),
  fairy(18),
  unknown(10001),
  shadow(10002);

  final int id;
  const PokeType(this.id);

  static PokeType fromNameOrUnknown(String raw) {
    final k = raw.toLowerCase();
    for (final t in PokeType.values) {
      if (t.name == k) return t;
    }
    return PokeType.unknown;
  }
}
