#include <iostream>
#include <string>
#include <random>
#include <fstream>

const int nIndividuals=2000;
const int nFactors=10;
double DataSet[nIndividuals][nFactors+1]={};

double F5(int i) {
	return 4*DataSet[i][0] + DataSet[i][4];
}

double F6(int i) {
	return DataSet[i][1] + 3*DataSet[i][3];
}

double F7(int i) {
	return 2*DataSet[i][2] + 3*DataSet[i][2];
}

double F8(int i) {
	return DataSet[i][3] - DataSet[i][1];
}

double F9(int i) {
	return DataSet[i][4] - DataSet[i][0];
}

double ANSWER(int i) {
	return (DataSet[i][5] - 3*DataSet[i][2] - 5*DataSet[i][8]);
}

void dump2csv(void) {
  std::ofstream out("Dataset.csv");
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

void dump2screen(void) {
  for (int j = -1; j < nIndividuals; j++) {
  	  if (j < 0) {
	  	  std::cout << "|                    |F1|F2|F3|F4|F5|F6|F7|F8|F9|ANSWER|" << std::endl;
	  } else {
		  std::cout << "| Individual " << j << "       |" << DataSet[j][0] << "|" <<  DataSet[j][1] << "|"
		  <<  DataSet[j][2] << "|"<<  DataSet[j][3] << "|"<<  DataSet[j][4] << "|"
				  <<  DataSet[j][5] << "|"<<  DataSet[6][j] << "|"<<  DataSet[j][7] << "|"
					  <<  DataSet[j][8] << "|"<<  DataSet[j][9] << "|"<<  DataSet[j][10] << "|" <<std::endl;	
	  }
  }
}


int main() {

  std::default_random_engine generator;
  std::normal_distribution<double> normal_distribution(50,10);
  std::exponential_distribution<double> exponential_distribution(10);
  std::uniform_real_distribution<double> uniform_real_distribution(20,50);
  std::weibull_distribution<double> weibull_distribution(25,2.0);
  std::cauchy_distribution<double> cauchy_distribution(5.0,1.0);


  for (int i=0; i<nIndividuals; ++i) {
    DataSet[i][0] = normal_distribution(generator);
    DataSet[i][1] = exponential_distribution(generator);
    DataSet[i][2] = uniform_real_distribution(generator);
    DataSet[i][3] = weibull_distribution(generator);
    DataSet[i][4] = cauchy_distribution(generator);

    DataSet[i][5] = F5(i);
    DataSet[i][6] = F6(i);
    DataSet[i][7] = F7(i);
    DataSet[i][8] = F8(i);
    DataSet[i][9] = F9(i);

    DataSet[i][10] = ANSWER(i);
  }

  dump2screen();
  dump2csv();

  return 0;
}
