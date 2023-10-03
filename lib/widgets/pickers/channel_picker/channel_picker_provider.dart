import 'package:flutter/cupertino.dart';
import 'package:lya_encuestas/classes/database/data_access/channel_da.dart';
import 'package:lya_encuestas/classes/database/models/channel.dart';

class ChannelPickerProvider with ChangeNotifier {
  List<Channel> _channels = [];

  List<Channel> get channels => _channels;

  ChannelPickerProvider() {
    reloadChannels();
  }

  void reloadChannels() {
    loadChannels().then((channels) {
      _channels = channels;
      notifyListeners();
    });
  }

  Future<List<Channel>> loadChannels() async {
    final data = Channel.parseModelList(await ChannelDA().list(null, null));
    data.sort(ascendingSort);
    print("Recargando canales");
    return data;
  }

  static int ascendingSort(Channel c1, Channel c2) =>
      c1.name.compareTo(c2.name);
}
