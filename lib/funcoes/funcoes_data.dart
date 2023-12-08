class FuncoesData {
  static String dataFormatada(String data) {
    if (data == null || data.isEmpty) {
      return '';
    }
    return '${data.substring(8, 10)}/${data.substring(5, 7)}/${data.substring(0, 4)}';
  }

  static String dataFormatadaHora(String data) {
    if (data == null || data.isEmpty) {
      return '';
    }
    // return '${data.substring(8, 10)}/${data.substring(5, 7)}/${data.substring(0, 4)} ${data.substring(11, 13)}:${data.substring(14, 16)}';
    return '${data.substring(8, 10)}/${data.substring(5, 7)}/${data.substring(0, 4)}';
  }

  static String dataFormatadaHoraSegundo(String data) {
    if (data == null || data.isEmpty) {
      return '';
    }
    return '${data.substring(8, 10)}/${data.substring(5, 7)}/${data.substring(0, 4)} ${data.substring(11, 13)}:${data.substring(14, 16)}:${data.substring(17, 19)}';
  }

  static String dataFormatadaHoraSegundoMilesegundo(String data) {
    if (data == null || data.isEmpty) {
      return '';
    }
    return '${data.substring(8, 10)}/${data.substring(5, 7)}/${data.substring(0, 4)} ${data.substring(11, 13)}:${data.substring(14, 16)}:${data.substring(17, 19)}.${data.substring(20, 23)}';
  }

  static String dataFormatadaHoraSegundoMilesegundoSemBarra(String data) {
    if (data == null || data.isEmpty) {
      return '';
    }
    return data.substring(0, 4) +
        data.substring(5, 7) +
        data.substring(8, 10) +
        data.substring(11, 13) +
        data.substring(14, 16) +
        data.substring(17, 19) +
        data.substring(20, 23);
  }

  static stringToDateTime(String data) {
    List<String> dataSplit = data.split('/');
    String dataFormatada =
        "${dataSplit[2]}-${dataSplit[1]}-${dataSplit[0]}T00:00:00";
    return dataFormatada;
  }
}
