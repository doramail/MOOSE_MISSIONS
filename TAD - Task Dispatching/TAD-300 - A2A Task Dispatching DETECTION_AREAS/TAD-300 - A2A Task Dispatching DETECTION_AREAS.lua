---
-- Name: TAD-300 - A2A Task Dispatching DETECTION_AREAS
-- Author: FlightControl
-- Date Created: 17 May 2017
--
-- # Situation:
-- 
-- This mission demonstrates the dynamic task dispatching for Air to Air operations.
-- Intruders are flying towards the EWR units. 
-- The detection method used is the DETECTION_AREAS method, which groups detected targets per detected area.
-- 
-- # Test cases: 
-- 
-- 1. Observe the EWR's detecting targets and grouping them. 
-- 2. Check that the HQ provides menus to engage on a task set by the EWRs.
-- 
local HQ = GROUP:FindByName( "HQ", "Bravo" )

local CommandCenter = COMMANDCENTER:New( HQ, "Lima" )

local Scoring = SCORING:New( "A2A Dispatching demo" )

local Mission = MISSION
  :New( CommandCenter, "A2A Mission", "High", "Watch the air enemy units being detected.", coalition.side.RED )
  :AddScoring( Scoring )

local EWRSet = SET_GROUP:New():FilterPrefixes( "EWR" ):FilterCoalitions("red"):FilterStart()

local EWRDetection = DETECTION_AREAS:New( EWRSet, 6000 )
EWRDetection:SetFriendliesRange( 10000 )
EWRDetection:SetDetectionInterval(30)


local AttackGroups = SET_GROUP:New():FilterCoalitions( "red" ):FilterPrefixes( "Defender" ):FilterStart()

TaskDispatcher = TASK_A2A_DISPATCHER:New( Mission, AttackGroups, EWRDetection )
TaskDispatcher:SetReportInterval(10)

