import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:pokemonapp/models/pokemonApi/pokemon_dto.dart';
import 'package:pokemonapp/models/pokemonApi/pomemon_model.dart';
import 'package:pokemonapp/models/pokemonApi/type_all.dart';

class PokeApi extends ChangeNotifier {
  String get urlBase => "https://pokeapi.co/api/v2/";

  List<Map<String, dynamic>> listPokemon = [{}];
  bool loading = false;
  int offset = 20;
  List<Map<String, dynamic>> listPokemonFavorite = [{}];
  bool loadingFavorite = false;
  int offsetAll = 0;

  bool loadingSearch = false;
  List<Map<String, dynamic>> listPokemonSearch = [{}];
  bool error = false;

  Future<void> searchPokemonByName(String name) async {
    loadingSearch = true;
    error = false;
    listPokemonSearch = [{}];
    notifyListeners();

    PokemonModel pokemonModel = await fetchPokemonByName(name);

    if (pokemonModel != null) {
      List<String> type = [];

      for (var item in pokemonModel.types) {
        type.add(item.type.name);
      }
      listPokemonSearch.add({
        'id': pokemonModel.id.toString(),
        'name': pokemonModel.name,
        'type': type,
        'image': pokemonModel.sprites.frontDefault,
        'image2': pokemonModel.sprites.backDefault,
        'hp': pokemonModel.states[0].baseStat,
        'attack': pokemonModel.states[1].baseStat,
        'defense': pokemonModel.states[2].baseStat,
        'special_attack': pokemonModel.states[3].baseStat,
        'special_defence': pokemonModel.states[4].baseStat,
        'speed': pokemonModel.states[5].baseStat,
        'weight': pokemonModel.weight,
        'height': pokemonModel.height,
      });
      error = false;
    } else {
      error = true;
    }

    loadingSearch = false;
    notifyListeners();
  }

  Future<List<TypeAll>> fetchAllPokemons(int offset) async {
    final response = await http
        .get(Uri.parse("${urlBase}pokemon?limit=20&offset=${offset - 20}"));

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var ret = new List<TypeAll>.from(
          body["results"].map((x) => TypeAll.fromJson(x)));
      return ret;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load get');
    }
  }

  Future<void> getListPokemonAll(int offset) async {
    this.loading = true;
    this.offset += offset;

    notifyListeners();

    List<TypeAll> allPokemons = await fetchAllPokemons(this.offset);

    if (allPokemons != null) {
      for (var i = 0; i < allPokemons.length; i++) {
        if (allPokemons[i].name != null) {
          PokemonModel pokemonModel =
              await fetchPokemonByName(allPokemons[i].name);

          List<String> type = [];

          for (var item in pokemonModel.types) {
            type.add(item.type.name);
          }

          this.listPokemon.add({
            'id': pokemonModel.id.toString(),
            'name': pokemonModel.name,
            'type': type,
            'image': pokemonModel.sprites.frontDefault,
            'image2': pokemonModel.sprites.backDefault,
            'hp': pokemonModel.states[0].baseStat,
            'attack': pokemonModel.states[1].baseStat,
            'defense': pokemonModel.states[2].baseStat,
            'special_attack': pokemonModel.states[3].baseStat,
            'special_defence': pokemonModel.states[4].baseStat,
            'speed': pokemonModel.states[5].baseStat,
            'weight': pokemonModel.weight,
            'height': pokemonModel.height,
          });
        }
      }
    }

    this.loading = false;
    notifyListeners();
  }

  Future<List<PokemonDto>> fetchPokemonsByType(String type) async {
    final response =
        await http.get(Uri.parse("${urlBase}type/$type?limit=20&offset=0"));

    if (response.statusCode == 200) {
      var listPokemon = List<PokemonDto>.from(
        json
            .decode(response.body)["pokemon"]
            .map((x) => x["pokemon"])
            .map((x) => PokemonDto.fromJson(x)),
      );

      return listPokemon;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load get');
    }
  }

  // ignore: missing_return
  Future<PokemonModel> fetchPokemonByName(String name) async {
    final response = await http.get(Uri.parse("${urlBase}pokemon/$name"));

    if (response.statusCode == 200) {
      return pokemonModelFromJson(response.body);
    } else {
      error = true;
      notifyListeners();
      // If that response was not OK, throw an error.
      // throw Exception('Failed to load get');
    }
  }

  Future<void> getListPokemon(
      List<PokemonDto> listPokemonDto, int offset, String userId) async {
    this.loading = true;
    this.offset += offset;
    notifyListeners();
    for (var i = offset; i < this.offset; i++) {
      if (listPokemonDto[i].name != null) {
        PokemonModel pokemonModel =
            await fetchPokemonByName(listPokemonDto[i].name);

        List<String> type = [];

        for (var item in pokemonModel.types) {
          type.add(item.type.name);
        }

        this.listPokemon.add({
          'id': pokemonModel.id.toString(),
          'name': pokemonModel.name,
          'type': type,
          'image': pokemonModel.sprites.frontDefault,
          'image2': pokemonModel.sprites.backDefault,
          'hp': pokemonModel.states[0].baseStat,
          'attack': pokemonModel.states[1].baseStat,
          'defense': pokemonModel.states[2].baseStat,
          'special_attack': pokemonModel.states[3].baseStat,
          'special_defence': pokemonModel.states[4].baseStat,
          'speed': pokemonModel.states[5].baseStat,
          'weight': pokemonModel.weight,
          'height': pokemonModel.height,
        });
      }
    }

    this.loading = false;
    notifyListeners();
  }

  Future<void> setFavorite({
    String userId,
    String idPokemon,
    String namePokemon,
    String url,
    String url2,
    List<String> type,
    int hp,
    int attack,
    int defense,
    int specialAttack,
    int specialDefence,
    int speed,
    int weight,
    int height,
  }) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("favorite")
        .doc(idPokemon)
        .set(
      {
        'namePokemon': namePokemon,
        'id': idPokemon,
        'image': url,
        'image2': url2,
        'hp': hp,
        'attack': attack,
        'defense': defense,
        'special_attack': specialAttack,
        'special_defence': specialDefence,
        'speed': speed,
        'weight': weight,
        'height': height,
      },
    );
    for (var item in type) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("favorite")
          .doc(idPokemon)
          .collection("types")
          .doc(item)
          .set(
        {},
      );
    }
  }

  Future<void> deleteFavorite(
      String userId, String idPokemon, List<String> type) async {
    for (var item in type) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("favorite")
          .doc(idPokemon)
          .collection("types")
          .doc(item)
          .delete();
    }
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("favorite")
        .doc(idPokemon)
        .delete();
  }
}
