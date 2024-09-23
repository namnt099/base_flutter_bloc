const _dtFormat1 = 'yyyy-MM-dd HH:mm:ss';
const _dtFormat2 = 'hh:mm a';
const _dtFormat3 = 'dd/MM HH:mm a';
const _dtFormat4 = 'yyyy-MM-dd';
const _dtFormat5 = 'MMM dd, yyyy';
const _dtFormat6 = 'yyyy-MM-ddTHH:mm:ss';
const _dtFormat8 = 'dd MMM - hh:mm';
const _dtFormat7 = 'dd/MM/yyyy';
const _dtFormat9 = 'MMM dd, yyyy HH:mm';
const _dtFormat10 = 'dd MMM, yyyy';
const _dtFormat11 = 'HH:mm dd/MM/yyyy';
const _dtFormat12 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
const _dtFormat13 = ' HH:mm MMM dd, yyyy';
const _dtFormat14 = 'hh:mm';

const _dtFormat16 = 'HH:mm';
const _dtFormat17 = 'dd MMM';

class DateTimeFormat {
  DateTimeFormat._();
  static const defaultF = _dtFormat1;
  static const hour = _dtFormat2;
  static const create = _dtFormat3;
  static const dob = _dtFormat4;
  static const createBlog = _dtFormat5;
  static const beDate = _dtFormat6;
  static const date = _dtFormat7;
  static const shortDateTime = _dtFormat8;
  static const longDateTime = _dtFormat9;
  static const longDate = _dtFormat10;
  static const hh = _dtFormat11;
  static const z = _dtFormat12;
  static const hm = _dtFormat13;
  static const hhMM = _dtFormat14;
  static const HHmm = _dtFormat16;
  static const ddMMM = _dtFormat17;
}
