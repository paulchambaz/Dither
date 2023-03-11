class Matrix {
  int[][] value;

  Matrix (int n, int m) {
    value = new int[n][m];
    for (int i=0; i<value.length; i++) {
      for (int j=0; j<value[i].length; j++) {
        value[i][j] = 0;
      }
    }
  }

  Matrix (int  n) {
    value = new int[n][n];
    for (int i=0; i<value.length; i++) {
      for (int j=0; j<value[i].length; j++) {
        value[i][j] = 0;
      }
    }
  }

  Matrix (int[][] matrix) {
    if (matrix.length > 0) {
      value = new int[matrix.length][matrix[0].length];
      for (int i=0; i<matrix.length; i++) {
        for (int j=0; j<matrix[i].length; j++) {
          value[i][j] = matrix[i][j];
        }
      }
    } else {
      println("Error in matrix construction : input matrix too small");
    }
  }

  Matrix (Matrix A, Matrix B, Matrix C, Matrix D) {
    if (A.Row() == B.Row() && C.Row() == D.Row() && A.Column() == C.Column() && B.Column() == D.Column() &&
      A.Column() + B.Column() == C.Column() + D.Column() && A.Row() + C.Row() == B.Row() + D.Row()) {
      value = new int[A.Row() + C.Row()][A.Column() + B.Column()];
      for (int i=0; i<value.length; i++) {
        for (int j=0; j<value[i].length; j++) {
          if (i<A.Column() && j<A.Row()) {
            value[i][j] = A.value[i][j];
          } else if (j<A.Row()) {
            value[i][j] = C.value[i - A.Column()][j];
          } else if (i<A.Column()) {
            value[i][j] = B.value[i][j - A.Row()];
          } else {
            value[i][j] = D.value[i - A.Column()][j - A.Row()];
          }
        }
      }
    } else {
      println("Error in matrix construction : matrix are not same size");
    }
  }

  int Row () {
    return value.length;
  }

  int Column () {
    return (value.length > 0) ? value[0].length : 0;
  }

  Matrix Mult (int scalar) {
    int[][] mult = new int[Row()][Column()];
    for (int i=0; i<mult.length; i++) {
      for (int j=0; j<mult[i].length; j++) {
        mult[i][j] = value[i][j] * scalar;
      }
    }
    return new Matrix(mult);
  }

  Matrix Add (int scalar) {
    int [][] add = new int[Row()][Column()];
    for (int i=0; i<add.length; i++) {
      for (int j=0; j<add[i].length; j++) {
        add[i][j] = value[i][j] + scalar;
      }
    }
    return new Matrix(add);
  }

  void Print () {
    for (int i=0; i<value.length; i++) {
      for (int j=0; j<value[i].length; j++) {
        print(value[i][j], "");
      }
      println();
    }
    println();
  }

  void PrintFormat () {
    print("{");
    for (int i=0; i<value.length; i++) {
      print("{");
      for (int j=0; j<value[i].length; j++) {
        print(value[i][j]);
        if (j < value[i].length - 1) {
          print(", ");
        }
      }
      print("}");
      if (i < value.length - 1) {
        print(", ");
      }
    }
    print("}");
  }
}
