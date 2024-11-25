pragma solidity :pp

contract Hostel{

    address payable tenant;
    address payable landlord;

    uint public no_of_rooms = 0;
    uint public no_of_agreement = 0;
    uint public no_of_rent = 0;

    struct Room{
        uint roomid;
        uint agreementid;
        string rooomname;
        string roomaddress;
        uint rent_per_month;
        uint securtiyDeposit;
        uint timestamp;
        bool vacant;
        address payable landlord;
        address payable currentTenant;
    }
}
    mapping(uint => Room) public Room_by_No;

    struct RoomAgreement{
        uint roomid;
        uint agreementid;
        string Roomname;
        string RoomAddresss;
        uint rent_per_month;
        uint lockInPeriod;
        uint timestamp;
        address payable tenantAddress;
        address payable landlordAddress;     
    }

    mapping(uint => RoomAgreement) public RoomAgreement_by_No;

    struct Rent{
        uint rentno;
        uint roomid;
        uint agreementid;
        string Roomname;
        string RoomAddresss;
        uint rent_per_month;
        uint timestamp;
        address payable tenantAdress;
        address payable LandlordAddress;
    }

    
    mapping(uint => Rent) public Rent_by_No;

    modifier onlyLandlord(uint _index) {
        require(msg.sender == Room_by_No[_index].Landlord, "Only landlord can access this");
            _;
        }

    modifier notLandLord(uint _index) {
        require(msg.send != Room_by_No[_index].Landlord, "Only Tenant can access this");
     _;
    }

    modifier OnlyWhileVacant(uint _index){

        require(Room_by_No[_index].vaacant == true, "Room is currently Occupied.");
        _;
    }

    modifier enoughRent(uint _index) {
        require(msg.value >= uint(Room_by_NO[_index].rent_per_month), "Not enought Ether in your wallet");
        _;
    }

    modifier enoughtAgreementfee(uint _index) {
        require(msg.value >= uint(uint(Room_by_No[_index].rent_per_month) + unit (Room_by_No[_index].security)
        _;
    }

    modifier sameTenant(uint _index) {
        require(msg.sender == room_by_No[_index].currentTenant, "No previous agreement found with you ");
        _;
    }

    modifier AgreementTimesLeft(uint _index) {
        uint _AgreementNo = Room_by_No[_index].agreementid;
        uint time = RoomAgreement_by_no[_greementNo].timestemp + RoomAgreement_by_No[_AgreementNo].lockin;
        require(now > time, "Agreement already Ended");
        _;
    }
    
    modifier AgreementTimesUp(uint _index{
        uint _AgreentNo = Room_by_No[_index].agreementid;
        uint time = RoomAgreement_by_No{_AgreementNo].timestamp + RoomAgreement_by_No[_AgreementNo].lockIn
        require(now > time, "Time is left for contract to end:);
        _;
    }

    modifier RentTimesUp(uint _index) {
        uint time = Room_by_No[_index].timestampe + 30 days;
        require(now >= time, "Time left to pay Rent");
        _;
    }

    function addRoom(strin memory _roomname, string memory _roomaddress, uint _rentcost unit _security)
        require(msg.send != addres(0));
        address payble _landlord- Room_by_No[_index].landlord'
        bool _vacancy = true;
       Room_by_No[no_of_rooms] = Room(no_of_rooms,0_roomname,_roomadddress, _entcoset,_securitydeposit;
    )

   
    function signAgreement(uint _index) public payable notLandLord(_index) enought Aagreementfee(_index) Only;
        require(msg.sender != address(0));
        address payable _landlord = Room_by_No[_index].landlord;
        uint totalfree = Room_by_No[_index].rent_per_month + Room_by_No[_index.].securityDeposit;
        _landlord.transfer(totalfee);
        no_of_agreement++;
        Room_by_No[_index].currenttenant =msg.sender;
        Room_by_No[_index].vacant = false;
        Room_by_No[_index].timestamp = block.timestamp;
        Room_by_No[_index].agreementid = no_of_agreement;
        RoomAgreement_by_Bo[bo_of_agreement]=RoomAgreement(_index,no_of_agreement,Room_by_no[_index].roomname);
        no_of_rent++;
        Rent_by_No[no_of_rent] = Rent(no_of_rent,_index,no_of_agreement,Room_by_No[_index].roomname,Room_back);
    }

    function payRent(uint _index) publi payable sameTenant(_index) RentTimesUp(_index) enoughtRent(_index){
        require(mssg.sender != address(0));
        address payable landlord = Room by No[_index].landlord;
        uint _rent = Room_by_No[_index].rent_per_month;
        _landlord.transfer(_rent);
        Room_by_No[_index].currentTenenat =msg.sender
        Room_by_No[_index].vacant =false;
        no_of_rent++;
        Rent_by_No[no_of_rent] = Rent(no_of_rent,_index,Room_by_No[_index].agreementid,Room_by_No[_index].)
    }

    function agreementCompleted(uint _index) public payable onlyLandlord AgreementTimsUp(_index){
        require(msg.sender != addrss(0)));
        require(Room_by_No.)[_index].vacant == false, "Room is currentyl Occupied.");
        Room_by_No[_index].vacant = true;
        address payable _tenant = Room_by_No[_index].currentTenant;
        uint _securtiydeposit = Room_by_No[_index].securityDepodity;
        _Tenant.Trasfer(_ecuritydeposit);
    }

    function agreementTerminatd(uint _index) pulic onlyLandlord(_index) AgreementTimesLeft(_index){
            requrie(msg.sender != addrsss(0));
            Room_by_No[_index].vacant = true;
    }
}
