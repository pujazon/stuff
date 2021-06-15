#include <iostream>
#include <string>
#include <random>
#include <fstream>

const int nIndividuals=33;
const int nFactors=10;
double DataSet[nIndividuals][nFactors+1]={};

void dump2csv(void) {
  std::ofstream out("Simulation1.csv");
  for (int i=0; i < nIndividuals; ++i) {
    for (int j=0; j < nFactors+1; ++j) {
	  if (i == 0) {
		std::string label = "#" + std::to_string(j);
		out << label << ','; 
	  } else {
        out << DataSet[i][j] << ',';
	  }
    }
    out << '\n';
  }
}

int main() {

    DataSet[1][0] =-30.222;
    DataSet[1][1] =-25.222;
    DataSet[1][2] =-31.222;
    DataSet[1][3] =-25.222;
    DataSet[1][4] =-18.222;
    DataSet[1][5] =-31.222;
    DataSet[1][6] =-31.222;
    DataSet[1][7] =-38.222;
    DataSet[1][8] =-31.222;
    DataSet[1][9] =-25.222;

    DataSet[2][0] =20.137;
    DataSet[2][1] =26.137;
    DataSet[2][2] =33.137;
    DataSet[2][3] =20.137;
    DataSet[2][4] =26.137;
    DataSet[2][5] =28.137;
    DataSet[2][6] =28.137;
    DataSet[2][7] =26.137;
    DataSet[2][8] =20.137;
    DataSet[2][9] =13.137;

    DataSet[3][0] =-31.222;
    DataSet[3][1] =-25.222;
    DataSet[3][2] =-18.222;
    DataSet[3][3] =-31.222;
    DataSet[3][4] =-25.222;
    DataSet[3][5] =-23.222;
    DataSet[3][6] =-23.222;
    DataSet[3][7] =-25.222;
    DataSet[3][8] =-31.222;
    DataSet[3][9] =-38.222;

    DataSet[4][0] =20.137;
    DataSet[4][1] =26.137;
    DataSet[4][2] =33.137;
    DataSet[4][3] =20.137;
    DataSet[4][4] =26.137;
    DataSet[4][5] =28.137;
    DataSet[4][6] =28.137;
    DataSet[4][7] =26.137;
    DataSet[4][8] =20.137;
    DataSet[4][9] =13.137;

    DataSet[5][0] =-121.072;
    DataSet[5][1] =-115.072;
    DataSet[5][2] =-108.072;
    DataSet[5][3] =-121.072;
    DataSet[5][4] =-115.072;
    DataSet[5][5] =-113.072;
    DataSet[5][6] =-113.072;
    DataSet[5][7] =-113.072;
    DataSet[5][8] =-121.072;
    DataSet[5][9] =-128.072;

    DataSet[6][0] =-69.713;
    DataSet[6][1] =-63.713;
    DataSet[6][2] =-56.713;
    DataSet[6][3] =-69.713;
    DataSet[6][4] =-63.713;
    DataSet[6][5] =-61.713;
    DataSet[6][6] =-61.713;
    DataSet[6][7] =-63.713;
    DataSet[6][8] =-69.713;
    DataSet[6][9] =-76.713;

    DataSet[7][0] =-121.072;
    DataSet[7][1] =-115.072;
    DataSet[7][2] =-108.072;
    DataSet[7][3] =-121.072;
    DataSet[7][4] =-115.072;
    DataSet[7][5] =-113.072;
    DataSet[7][6] =-113.072;
    DataSet[7][7] =-115.072;
    DataSet[7][8] =-121.072;
    DataSet[7][9] =-128.072;

    DataSet[8][0] =-69.713;
    DataSet[8][1] =-63.713;
    DataSet[8][2] =-56.713;
    DataSet[8][3] =-69.713;
    DataSet[8][4] =-63.713;
    DataSet[8][5] =-61.713;
    DataSet[8][6] =-61.713;
    DataSet[8][7] =-63.713;
    DataSet[8][8] =-69.713;
    DataSet[8][9] =-76.713;

    DataSet[9][0] =-26.472;
    DataSet[9][1] =-20.472;
    DataSet[9][2] =-13.472;
    DataSet[9][3] =-26.472;
    DataSet[9][4] =-20.472;
    DataSet[9][5] =-18.472;
    DataSet[9][6] =-18.472;
    DataSet[9][7] =-20.472;
    DataSet[9][8] =-26.472;
    DataSet[9][9] =-33.472;

    DataSet[10][0] =24.886;
    DataSet[10][1] =30.886;
    DataSet[10][2] =37.886;
    DataSet[10][3] =24.886;
    DataSet[10][4] =30.886;
    DataSet[10][5] =32.886;
    DataSet[10][6] =32.886;
    DataSet[10][7] =30.886;
    DataSet[10][8] =24.886;
    DataSet[10][9] =17.886;


    DataSet[11][0] =-26.472;
    DataSet[11][1] =-20.472;
    DataSet[11][2] =-13.472;
    DataSet[11][3] =-26.472;
    DataSet[11][4] =-20.472;
    DataSet[11][5] =-18.472;
    DataSet[11][6] =-18.472;
    DataSet[11][7] =-20.472;
    DataSet[11][8] =-26.472;
    DataSet[11][9] =-33.472;

    DataSet[12][0] =24.886;
    DataSet[12][1] =30.886;
    DataSet[12][2] =37.886;
    DataSet[12][3] =24.886;
    DataSet[12][4] =30.886;
    DataSet[12][5] =32.886;
    DataSet[12][6] =32.886;
    DataSet[12][7] =30.886;
    DataSet[12][8] =24.886;
    DataSet[12][9] =17.886;

    DataSet[13][0] =-116.322;
    DataSet[13][1] =-110.322;
    DataSet[13][2] =-103.322;
    DataSet[13][3] =-116.322;
    DataSet[13][4] =-110.322;
    DataSet[13][5] =-108.322;
    DataSet[13][6] =-108.322;
    DataSet[13][7] =-110.322;
    DataSet[13][8] =-116.322;
    DataSet[13][9] =-123.322;

    DataSet[14][0] =-64.964;
    DataSet[14][1] =-58.964;
    DataSet[14][2] =-51.964;
    DataSet[14][3] =-64.964;
    DataSet[14][4] =-58.964;
    DataSet[14][5] =-56.964;
    DataSet[14][6] =-56.964;
    DataSet[14][7] =-58.964;
    DataSet[14][8] =-64.964;
    DataSet[14][9] =-71.964;

    DataSet[15][0] =-116.322;
    DataSet[15][1] =-110.322;
    DataSet[15][2] =-103.322;
    DataSet[15][3] =-116.322;
    DataSet[15][4] =-110.322;
    DataSet[15][5] =-108.322;
    DataSet[15][6] =-108.322;
    DataSet[15][7] =-110.322;
    DataSet[15][8] =-116.322;
    DataSet[15][9] =-123.322;

    DataSet[16][0] =243.956;
    DataSet[16][1] =249.956;
    DataSet[16][2] =256.956;
    DataSet[16][3] =243.956;
    DataSet[16][4] =249.956;
    DataSet[16][5] =251.956;
    DataSet[16][6] =251.956;
    DataSet[16][7] =249.956;
    DataSet[16][8] =243.956;
    DataSet[16][9] =236.956;

    DataSet[17][0] =277.698;
    DataSet[17][1] =283.698;
    DataSet[17][2] =290.698;
    DataSet[17][3] =277.698;
    DataSet[17][4] =283.698;
    DataSet[17][5] =285.698;
    DataSet[17][6] =285.698;
    DataSet[17][7] =283.698;
    DataSet[17][8] =277.698;
    DataSet[17][9] =270.698;

    DataSet[18][0] =329.057;
    DataSet[18][1] =335.057;
    DataSet[18][2] =342.057;
    DataSet[18][3] =329.057;
    DataSet[18][4] =335.057;
    DataSet[18][5] =337.057;
    DataSet[18][6] =337.057;
    DataSet[18][7] =335.057;
    DataSet[18][8] =329.057;
    DataSet[18][9] =329.057;

    DataSet[19][0] =277.698;
    DataSet[19][1] =283.698;
    DataSet[19][2] =290.698;
    DataSet[19][3] =277.698;
    DataSet[19][4] =283.698;
    DataSet[19][5] =285.698;
    DataSet[19][6] =285.698;
    DataSet[19][7] =283.698;
    DataSet[19][8] =277.698;
    DataSet[19][9] =270.698;

    DataSet[20][0] =329.057;
    DataSet[20][1] =335.057;
    DataSet[20][2] =342.057;
    DataSet[20][3] =329.057;
    DataSet[20][4] =335.057;
    DataSet[20][5] =337.057;
    DataSet[20][6] =337.057;
    DataSet[20][7] =335.057;
    DataSet[20][8] =329.057;
    DataSet[20][9] =329.057;


    DataSet[21][0] =187.848;
    DataSet[21][1] =193.848;
    DataSet[21][2] =200.848;
    DataSet[21][3] =187.848;
    DataSet[21][4] =193.848;
    DataSet[21][5] =195.848;
    DataSet[21][6] =195.848;
    DataSet[21][7] =193.848;
    DataSet[21][8] =187.848;
    DataSet[21][9] =180.848;


    DataSet[22][0] =239.207;
    DataSet[22][1] =245.207;
    DataSet[22][2] =252.207;
    DataSet[22][3] =239.207;
    DataSet[22][4] =245.207;
    DataSet[22][5] =247.207;
    DataSet[22][6] =247.207;
    DataSet[22][7] =245.207;
    DataSet[22][8] =239.207;
    DataSet[22][9] =232.207;


    DataSet[23][0] =187.848;
    DataSet[23][1] =193.848;
    DataSet[23][2] =200.848;
    DataSet[23][3] =187.848;
    DataSet[23][4] =193.848;
    DataSet[23][5] =195.848;
    DataSet[23][6] =195.848;
    DataSet[23][7] =193.848;
    DataSet[23][8] =187.848;
    DataSet[23][9] =180.848;

    DataSet[24][0] =239.207;
    DataSet[24][1] =245.207;
    DataSet[24][2] =252.207;
    DataSet[24][3] =239.207;
    DataSet[24][4] =245.207;
    DataSet[24][5] =247.207;
    DataSet[24][6] =247.207;
    DataSet[24][7] =245.207;
    DataSet[24][8] =239.207;
    DataSet[24][9] =232.207;


    DataSet[25][0] =282.448;
    DataSet[25][1] =288.448;
    DataSet[25][2] =295.448;
    DataSet[25][3] =282.448;
    DataSet[25][4] =288.448;
    DataSet[25][5] =290.448;
    DataSet[25][6] =290.448;
    DataSet[25][7] =288.448;
    DataSet[25][8] =282.448;
    DataSet[25][9] =275.448;


    DataSet[26][0] =333.806;
    DataSet[26][1] =339.806;
    DataSet[26][2] =346.806;
    DataSet[26][3] =333.806;
    DataSet[26][4] =339.806;
    DataSet[26][5] =341.806;
    DataSet[26][6] =341.806;
    DataSet[26][7] =339.806;
    DataSet[26][8] =333.806;
    DataSet[26][9] =326.806;


    DataSet[27][0] =282.448;
    DataSet[27][1] =288.448;
    DataSet[27][2] =295.448;
    DataSet[27][3] =282.448;
    DataSet[27][4] =288.448;
    DataSet[27][5] =290.448;
    DataSet[27][6] =290.448;
    DataSet[27][7] =288.448;
    DataSet[27][8] =282.448;
    DataSet[27][9] =275.448;


    DataSet[28][0] =333.806;
    DataSet[28][1] =339.806;
    DataSet[28][2] =346.806;
    DataSet[28][3] =333.806;
    DataSet[28][4] =339.806;
    DataSet[28][5] =341.806;
    DataSet[28][6] =341.806;
    DataSet[28][7] =339.806;
    DataSet[28][8] =333.806;
    DataSet[28][9] =326.806;


    DataSet[29][0] =192.598;
    DataSet[29][1] =198.598;
    DataSet[29][2] =205.598;
    DataSet[29][3] =192.598;
    DataSet[29][4] =198.598;
    DataSet[29][5] =200.598;
    DataSet[29][6] =200.598;
    DataSet[29][7] =198.598;
    DataSet[29][8] =192.598;
    DataSet[29][9] =185.598;


    DataSet[30][0] =243.956;
    DataSet[30][1] =249.956;
    DataSet[30][2] =256.956;
    DataSet[30][3] =243.956;
    DataSet[30][4] =249.956;
    DataSet[30][5] =251.956;
    DataSet[30][6] =251.956;
    DataSet[30][7] =249.956;
    DataSet[30][8] =243.956;
    DataSet[30][9] =236.956;

    DataSet[31][0] =192.598;
    DataSet[31][1] =198.598;
    DataSet[31][2] =205.598;
    DataSet[31][3] =192.598;
    DataSet[31][4] =198.598;
    DataSet[31][5] =200.598;
    DataSet[31][6] =200.598;
    DataSet[31][7] =198.598;
    DataSet[31][8] =192.598;
    DataSet[31][9] =185.598;

    DataSet[32][0] =243.956;
    DataSet[32][1] =249.956;
    DataSet[32][2] =256.956;
    DataSet[32][3] =243.956;
    DataSet[32][4] =249.956;
    DataSet[32][5] =251.956;
    DataSet[32][6] =251.956;
    DataSet[32][7] =249.956;
    DataSet[32][8] =243.956;
    DataSet[32][9] =236.956;

  dump2csv();


  return 0;
}
