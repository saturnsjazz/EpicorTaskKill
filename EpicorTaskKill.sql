-- GET THE TASK ID THAT IS STILL ACTIVE (CHECK THE LIST AND COPY THE ID)
select SysTaskNum, TaskDescription, TaskType,
StartedOn = DATEADD(hour, -5, StartedOn),
EndedOn = DATEADD(hour, -5, EndedOn),
SubmitUser, TaskStatus, Company, AgentID,
AgentSchedNum, AgentTaskNum, RunProcedure,
InitiatorSource, ActivityMsg, History, TaskNote,
LastActivityOn = LastActivityOn,
UserPIDInfo, ProcessID, IsSystemTask
from ice.systask where TaskType = 'Process' and TaskDescription = 'Process MRP' and StartedOn > '20201101'

--Then you just replace the number for @taskid variable in the following script 

begin tran
declare @taskid int = 564615
select * from ice.systask where SysTaskNum = @taskid --TaskType = 'Process' and TaskDescription = 'Process MRP' and StartedOn > '2018-07-30'
select * from ice.SysTaskLog where SysTaskNum = @taskid -- 291812
select * from ice.systaskKill where SysTaskNum = @taskid -- 291812
select * from ice.SysTaskParam st where st.SysTaskNum = @taskid
 
update ice.systask
set TaskStatus = 'CANCELLED', history = 1 -- ACTIVE
WHERE SysTaskNum = @taskid
 
--delete from ice.systask where SysTaskNum = @taskid
 
DELETE FROM ice.systaskKill
where SysTaskNum = @taskid
 
/*INSERT INTO ice.SysTaskKill(SysTaskNum) VALUES(@taskid)*/
 
rollback tran
