class MyAppsDao {
  final String app_name;
  final String app_status;

  MyAppsDao(this.app_name, this.app_status);

  factory MyAppsDao.fromJson(json){
    return MyAppsDao(
      json['id'],
      json['app_status'],
    );
  }
}