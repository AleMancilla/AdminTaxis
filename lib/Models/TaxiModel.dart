class TaxiModel {
  double heading;
  double accuracy;
  double speedAccuracy;
  String timestamp;
  double altitude;
  String   isMocked;
  double speed;
  double latitude;
  double longitude;

  TaxiModel.fromJson(Map json){
    this.heading        = double.parse(json['heading']);
    this.accuracy       = double.parse(json['accuracy']);
    this.speedAccuracy  = double.parse(json['speedAccuracy']);
    this.timestamp      = json['timestamp'];
    this.altitude       = double.parse(json['altitude']);
    this.isMocked       = json['isMocked'];
    this.speed          = double.parse(json['speed']);
    this.latitude       = double.parse(json['latitude']);
    this.longitude      = double.parse(json['longitude']);
  }

  
}