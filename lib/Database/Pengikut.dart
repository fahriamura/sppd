class Pengikut {
  final String Id;
  final String Jenis;
  final String Nama;
  final String Organisasi;
  final String tipe;
  final String berangkat;
  final String tujuan;
  final DateTime? periodeAwal;
  final DateTime? periodeAkhir;
  final String tujuanBisnis;
  final String wilayah;
  final String status;
  final String golongan;
  final String jabatan;
  final String jenisTujuan;


  Pengikut({
    required this.Id,
    required this.Jenis,
    required this.Nama,
    required this.Organisasi,
    required this.tipe,
    required this.berangkat,
    required this.tujuan,
    this.periodeAwal,
    this.periodeAkhir,
    required this.tujuanBisnis,
    required this.wilayah,
    required this.status,
    required this.golongan,
    required this.jabatan,
    required this.jenisTujuan,
  });

  factory Pengikut.fromJson(Map<String, dynamic> json) {

    return Pengikut(
      Id: json['PTCPNT_ID'],
      Jenis: json['PTCPNT_TP_CD'] ?? '',
      Nama: json['PTCPNT_NM'] ?? '',
      Organisasi: json['GVRMT_ORG_NM'] ?? '',
      tipe: json['SPPD_TP_CD'] ?? '',
      berangkat: json['SPPD_ORG_MEMO'] ?? '',
      tujuan: json['SPPD_DEST_MEMO'] ?? '',
      periodeAwal: json['SPPD_STR_DT'] != null ? DateTime.parse(json['SPPD_STR_DT']) : null,
      periodeAkhir: json['SPPD_END_DT'] != null ? DateTime.parse(json['SPPD_END_DT']) : null,
      tujuanBisnis: json['SPPD_OBJ_MEMO'] ?? '',
      wilayah: json['REGN_TP_CD'] ?? '',
      status: json['SPPD_STAT_CD'] ?? '',
      golongan: json['GRD_CD'] ?? '',
      jabatan: json['SPPD_CLS_CD'] ?? '',
      jenisTujuan: json['DEST_TP_CD'] ?? '',
    );
  }
}