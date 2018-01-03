trigger DuplicateName on Account (BEFORE INSERT,BEFORE UPDATE)
{
FOR(account a:trigger.new)
{
list<Account> acc=[select id,Name, Phone from Account where name=:a.name and phone=:a.phone and Id != :a.Id];
if(acc.size()>0)
{
a.name.adderror('you canot enter the duplicate values');
a.phone.adderror('you canot enter the duplicate values');
 }
  }
    }