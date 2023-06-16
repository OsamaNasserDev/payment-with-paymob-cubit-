abstract class InfoStates {} // Parent State

class InfoInitialState extends InfoStates {}



class GetFirstTokenLoadingState extends InfoStates {}
class GetFirstTokenSuccessState extends InfoStates {}
class GetFirstTokenFailState extends InfoStates {}

class GetOrderIDLoadingState extends InfoStates {}
class GetOrderIDSuccessState extends InfoStates {}
class GetOrderIDFailState extends InfoStates {}


class GetLastTokenLoadingState extends InfoStates {}
class GetLastTokenSuccessState extends InfoStates {}
class GetLastTokenFailState extends InfoStates {}


class GetKioskPaymentsLoadingState extends InfoStates {}
class GetKioskPaymentsSuccessState extends InfoStates {}
class GetKioskPaymentsFailState extends InfoStates {}


class GetSmartWalletsPaymentsLoadingState extends InfoStates {}
class GetSmartWalletsPaymentsSuccessState extends InfoStates {}
class GetSmartWalletsPaymentsFailState extends InfoStates {}

class UpdateCards extends InfoStates {}


class InfoChooseUserState extends InfoStates {}
