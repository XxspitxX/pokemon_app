abstract class ApiPaths {
  ApiPaths._();

  static const _baseApi = 'https://pokeapi.co/api/v2/';
  static const getAllPokemon = '${_baseApi}pokemon';

  static String getPokemon(String url) => url;
  static String getPokemonType(String url) => url;

  static const headers = {
    'Content-Type': 'application/json',
  };
}
