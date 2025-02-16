Below are the series which we need to apply the infrastructure in AWS, This is very impportant, we need to follow in the below series only. 
while destroying the infra just opposite to the below.

00-vpc

10-sg

20-bastion    [This bastion server will mostly use by Devops/SRE team]

30-vpn        [This VPN concept is very useful to Developers, as they dont have Private subnet access, but for testing purpose of their backend activities using api they use VPN concept. from VPN they will hit ALB to verify the response from servers if everything is fine or not]

40-rds         [developers can get access to RDS From VPN to verify if data is fine or not]
50-app-alb
