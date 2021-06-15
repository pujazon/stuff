#include <iostream>
#include <string>
#include <random>
#include <fstream>

const int nIndividuals=4;
const int nFactors=10;
double DataSet[nIndividuals][nFactors+1]={};

void dump2csv(void) {
  std::ofstream out("Simulation1.csv");
  for (int i=-1; i < nIndividuals; ++i) {
    for (int j=0; j < nFactors+1; ++j) {
	  if (i < 0) {
		std::string label = "Factor " + std::to_string(j);
		out << label << ','; 
	  } else {
        out << DataSet[i][j] << ',';
	  }
    }
    out << '\n';
  }
}

int main() {

    DataSet[0][0] =-30.222;
    DataSet[0][1] =-25.222;
    DataSet[0][2] =-31.222;
    DataSet[0][3] =-25.222;
    DataSet[0][4] =-18.222;
    DataSet[0][5] =-31.222;
    DataSet[0][6] =-31.222;
    DataSet[0][7] =-38.222;
    DataSet[0][8] =-31.222;
    DataSet[0][9] =-25.222;

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
/*
    DataSet[3][0] =
    DataSet[3][1] =
    DataSet[3][2] =
    DataSet[3][3] =
    DataSet[3][4] =
    DataSet[3][5] =
    DataSet[3][6] =
    DataSet[3][7] =
    DataSet[3][8] =
    DataSet[3][9] =

    DataSet[3][0] =
    DataSet[3][1] =
    DataSet[3][2] =
    DataSet[3][3] =
    DataSet[3][4] =
    DataSet[3][5] =
    DataSet[3][6] =
    DataSet[3][7] =
    DataSet[3][8] =
    DataSet[3][9] =

*/

  dump2csv();


  return 0;
}
