

String convertTransportasiDisplayToPost(String displayValue) {
  switch (displayValue) {
    case 'Pesawat':
      return 'C8001';
    default:
      return displayValue;
  }
}

String convertPostToDisplay(String displayValue) {
  switch (displayValue) {
    case 'C8001':
      return 'Pesawat';
    default:
      return displayValue;
  }
}