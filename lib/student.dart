void main() { 
  List datas = [{'Company': 'walton', 'item': 'walton32', 'Categories': 'tv', 'record': '0', 'key': '-NCrWT2T5i2lC8vP42fz'},
                {'Company': 'walton', 'item': 'walton pro max', 'Categories': 'mobile', 'record': '1', 'key': '-NCrW_T-CFvWbTDbacmQ'}, 
                {'Company': 'samsung', 'item': 'Samsung pro', 'Categories': 'mobile', 'record': '3', 'key': '-NCrXvUtPfsnJea5i30e'},
                {'Company': 'samsung', 'item': 'tv samsung', 'Categories': 'tv', 'record': '4', 'key': '-NCrY-4heNrgiqW8vI0H'}];
String com = 'walton';
String items = "walton32";

  for(int i=0;i<=datas.length-1;i++){
    //print(datas[i]['Company']);
    if(datas[i]['Company'] == com && datas[i]['item'] == items){
        print("valid");
    }
    else{
        print("invalid");
    }
  }
}