class Response {
  Player player;
  String update;
  List<Transfers> transfers;

  Response({this.player, this.update, this.transfers});

  Response.fromJson(Map<String, dynamic> json) {
    player = json['player'] != null ? new Player.fromJson(json['player']) : null;
    update = json['update'];
    if (json['transfers'] != null) {
      transfers = new List<Transfers>();
      json['transfers'].forEach((v) { transfers.add(new Transfers.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.player != null) {
      data['player'] = this.player.toJson();
    }
    data['update'] = this.update;
    if (this.transfers != null) {
      data['transfers'] = this.transfers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Player {
  int id;
  String name;

  Player({this.id, this.name});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Transfers {
  String date;
  String type;
  Teams teams;

  Transfers({this.date, this.type, this.teams});

  Transfers.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    type = json['type'];
    teams = json['teams'] != null ? new Teams.fromJson(json['teams']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['type'] = this.type;
    if (this.teams != null) {
      data['teams'] = this.teams.toJson();
    }
    return data;
  }
}

class Teams {
  In teamIn;

  Teams({this.teamIn});

  Teams.fromJson(Map<String, dynamic> json) {
    teamIn = json['in'] != null ? new In.fromJson(json['in']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teamIn != null) {
      data['in'] = this.teamIn.toJson();
    }
    return data;
  }
}

class In {
  int id;
  String name;
  String logo;

  In({this.id, this.name, this.logo});

  In.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}