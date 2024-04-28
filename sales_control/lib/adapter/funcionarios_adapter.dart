String nomeFuncionario(String nomeFuncionario) {
  if(nomeFuncionario == 'p@gmail.com'){
    nomeFuncionario = 'Pedro';
    return nomeFuncionario;
  } else if(nomeFuncionario == 'je@gmail.com'){
    nomeFuncionario = 'José Eudes';
    return nomeFuncionario;
  } else if(nomeFuncionario == 'rss@gmail.com'){
    nomeFuncionario = 'Rafael';
    return nomeFuncionario;
  } else if(nomeFuncionario == 's@gmail.com'){
    nomeFuncionario = 'Suemo';
    return nomeFuncionario;
  } else if(nomeFuncionario == 'mj@gmail.com'){
    nomeFuncionario = 'Marcos José';
    return nomeFuncionario;
  }
  return 'Funcionário não encontrado';
}
