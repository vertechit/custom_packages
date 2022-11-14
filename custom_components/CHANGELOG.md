# Change Log
Esse arquivo contém um relatório de versões e as suas alterações. 


<!-- ================================== v0.1.0  ================================== -->
---
## [0.1.0] - EM DESENVOLVIMENTO

### Fixed
- Foi corrigido a validação NotEmptyValidation(). Estava retornando uma mensagem de erro fixa ao invés de retornar a mensagem definida pelo usuário através do parametro validationFailTxt. 


<!-- ================================== v0.1.0  ================================== -->
---
## [0.1.0] - 31-01-2022
  
Implementado o novo processo de validação de formulários. Agora cada component TextField recebe como parametro uma validação baseada na interface ITextFieldValidation. Serão disponibilizadas diferentes classes de validação, como por exemplo: Validação de campo vazio, validação de CPF, etc. 

### Added
- Implementado novo processo de validação. Esse novo processo é baseado em validações criadas com base na interface "ITextFieldValidation". Agora os Text Fields podem receber diferentes classes responsáveis pela validação, através do parametro "validation". Nessa versão, foi desenvolvido apenas um metodo de validação NotEmptyValidation.
 
### Changed
- Paramêtro "isRequired" dos TextField se tornou obsoleto. Agora a validação do formulário é feita seguindo outro processo. 
 
### Fixed

<!-- ================================== v0.0.2  ================================== -->

---
## [0.0.2] - 21-01-2022
  
Release gerada antes da alteração no processo de validação de formulários. 


<!-- ================================== v0.0.1  ================================== -->
---
## [0.0.1] - 07-10-2021
  
Versão inicial do package.






 
