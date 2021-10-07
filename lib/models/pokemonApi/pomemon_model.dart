import 'dart:convert';

PokemonModel pokemonModelFromJson(String str) {
    final jsonData = json.decode(str);
    return PokemonModel.fromJson(jsonData);
}

String pokemonModelToJson(PokemonModel data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class PokemonModel {
    int id;
    String name;
    int height;
    int weight;
    List<AbilityElement> abilities;
    Sprites sprites;
    List<TypeElement> types;
    List<StatsStats> states;

    PokemonModel({
        this.id,
        this.name,
        this.height,
        this.weight,
        this.abilities,
        this.sprites,
        this.types,
        this.states,
    });

    factory PokemonModel.fromJson(Map<String, dynamic> json) => new PokemonModel(
        id:  json["id"],
        name: json["name"],
        height: json["height"],
        weight: json["weight"],
        abilities: new List<AbilityElement>.from(json["abilities"].map((x) => AbilityElement.fromJson(x))),
        sprites: Sprites.fromJson(json["sprites"]),
        states: new List<StatsStats>.from(json["stats"].map((x) => StatsStats.fromJson(x))),
        types: new List<TypeElement>.from(json["types"].map((x) => TypeElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'id' : id,
        "name": name,
        "height": height,
        "weight": weight,
        "abilities": new List<dynamic>.from(abilities.map((x) => x.toJson())),
        "sprites": sprites.toJson(),
        "base_stat" : new List<dynamic>.from(states.map((x) => x.toJson())),
        "types": new List<dynamic>.from(types.map((x) => x.toJson())),
    };
}



class AbilityElement {
    AbilityAbility ability;

    AbilityElement({
        this.ability,
    });

    factory AbilityElement.fromJson(Map<String, dynamic> json) => new AbilityElement(
        ability: AbilityAbility.fromJson(json["ability"]),
    );

    Map<String, dynamic> toJson() => {
        "ability": ability.toJson(),
    };
}

class AbilityAbility {
    String name;

    AbilityAbility({
        this.name,
    });

    factory AbilityAbility.fromJson(Map<String, dynamic> json) => new AbilityAbility(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class Sprites {
    String frontDefault;
    String backDefault;

    Sprites({
        this.frontDefault,
        this.backDefault,
    });

    factory Sprites.fromJson(Map<String, dynamic> json) => new Sprites(
        frontDefault: json["front_default"],
        backDefault: json["back_default"],

    );

    Map<String, dynamic> toJson() => {
        "front_default": frontDefault,
    };
}

class TypeElement {
    int slot;
    TypeType type;

    TypeElement({
        this.slot,
        this.type,
    });

    factory TypeElement.fromJson(Map<String, dynamic> json) => new TypeElement(
        slot: json["slot"],
        type: TypeType.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
    };
}

class TypeType {
    String name;
    String url;

    TypeType({
        this.name,
        this.url,
    });

    factory TypeType.fromJson(Map<String, dynamic> json) => new TypeType(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };


    
}

// class StatsElement {
//     StatsStats ability;

//     StatsElement({
//         this.ability,
//     });

//     factory StatsElement.fromJson(Map<String, dynamic> json) => new StatsElement(
//         ability: StatsStats.fromJson(json["ability"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "ability": ability.toJson(),
//     };
// }

class StatsStats {
    int baseStat;

    StatsStats({
        this.baseStat,
    });

    factory StatsStats.fromJson(Map<String, dynamic> json) => new StatsStats(
        baseStat: json["base_stat"],
    );

    Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
    };
}

