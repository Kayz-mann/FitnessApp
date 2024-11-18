//
//  HKWorkoutActivityType+Ext.swift
//  FitnessApp
//
//  Created by Balogun Kayode on 16/11/2024.
//

import Foundation
import SwiftUI
import HealthKit


extension HKWorkoutActivityType {

    /*
     Simple mapping of available workout types to a human readable name.
     */
    var name: String {
        switch self {
        case .americanFootball:             return "American Football"
        case .archery:                      return "Archery"
        case .australianFootball:           return "Australian Football"
        case .badminton:                    return "Badminton"
        case .baseball:                     return "Baseball"
        case .basketball:                   return "Basketball"
        case .bowling:                      return "Bowling"
        case .boxing:                       return "Boxing"
        case .climbing:                     return "Climbing"
        case .crossTraining:                return "Cross Training"
        case .curling:                      return "Curling"
        case .cycling:                      return "Cycling"
        case .dance:                        return "Dance"
        case .danceInspiredTraining:        return "Dance Inspired Training"
        case .elliptical:                   return "Elliptical"
        case .equestrianSports:             return "Equestrian Sports"
        case .fencing:                      return "Fencing"
        case .fishing:                      return "Fishing"
        case .functionalStrengthTraining:   return "Functional Strength Training"
        case .golf:                         return "Golf"
        case .gymnastics:                   return "Gymnastics"
        case .handball:                     return "Handball"
        case .hiking:                       return "Hiking"
        case .hockey:                       return "Hockey"
        case .hunting:                      return "Hunting"
        case .lacrosse:                     return "Lacrosse"
        case .martialArts:                  return "Martial Arts"
        case .mindAndBody:                  return "Mind and Body"
        case .mixedMetabolicCardioTraining: return "Mixed Metabolic Cardio Training"
        case .paddleSports:                 return "Paddle Sports"
        case .play:                         return "Play"
        case .preparationAndRecovery:       return "Preparation and Recovery"
        case .racquetball:                  return "Racquetball"
        case .rowing:                       return "Rowing"
        case .rugby:                        return "Rugby"
        case .running:                      return "Running"
        case .sailing:                      return "Sailing"
        case .skatingSports:                return "Skating Sports"
        case .snowSports:                   return "Snow Sports"
        case .soccer:                       return "Soccer"
        case .softball:                     return "Softball"
        case .squash:                       return "Squash"
        case .stairClimbing:                return "Stair Climbing"
        case .surfingSports:                return "Surfing Sports"
        case .swimming:                     return "Swimming"
        case .tableTennis:                  return "Table Tennis"
        case .tennis:                       return "Tennis"
        case .trackAndField:                return "Track and Field"
        case .traditionalStrengthTraining:  return "Traditional Strength Training"
        case .volleyball:                   return "Volleyball"
        case .walking:                      return "Walking"
        case .waterFitness:                 return "Water Fitness"
        case .waterPolo:                    return "Water Polo"
        case .waterSports:                  return "Water Sports"
        case .wrestling:                    return "Wrestling"
        case .yoga:                         return "Yoga"

        // iOS 10
        case .barre:                        return "Barre"
        case .coreTraining:                 return "Core Training"
        case .crossCountrySkiing:           return "Cross Country Skiing"
        case .downhillSkiing:               return "Downhill Skiing"
        case .flexibility:                  return "Flexibility"
        case .highIntensityIntervalTraining:    return "High Intensity Interval Training"
        case .jumpRope:                     return "Jump Rope"
        case .kickboxing:                   return "Kickboxing"
        case .pilates:                      return "Pilates"
        case .snowboarding:                 return "Snowboarding"
        case .stairs:                       return "Stairs"
        case .stepTraining:                 return "Step Training"
        case .wheelchairWalkPace:           return "Wheelchair Walk Pace"
        case .wheelchairRunPace:            return "Wheelchair Run Pace"

        // iOS 11
        case .taiChi:                       return "Tai Chi"
        case .mixedCardio:                  return "Mixed Cardio"
        case .handCycling:                  return "Hand Cycling"

        // iOS 13
        case .discSports:                   return "Disc Sports"
        case .fitnessGaming:                return "Fitness Gaming"

        // Catch-all
        default:                            return "Other"
        }
    }
    
    var image: String {
        let symbolName: String
        switch self {
        case .americanFootball:             return "figure.american.football"
        case .archery:                      return "figure.archery"
        case .australianFootball:           return "figure.australian.football"
        case .badminton:                    return "figure.badminton"
        case .baseball:                     return "figure.baseball"
        case .basketball:                   return "figure.basketball"
        case .bowling:                      return "figure.bowling"
        case .boxing:                       return "figure.boxing"
        case .climbing:                     return "figure.climbing"
        case .crossTraining:                return "figure.mixed.cardio"
        case .curling:                      return "figure.curling"
        case .cycling:                      return "figure.cycling"
        case .dance:                        return "figure.dance"
        case .danceInspiredTraining:        return "figure.dance"
        case .elliptical:                   return "figure.elliptical"
        case .equestrianSports:             return "figure.equestrian.sports"
        case .fencing:                      return "figure.fencing"
        case .fishing:                      return "figure.fishing"
        case .functionalStrengthTraining:   return "figure.strengthtraining.functional"
        case .golf:                         return "figure.golf"
        case .gymnastics:                   return "figure.gymnastics"
        case .handball:                     return "figure.handball"
        case .hiking:                       return "figure.hiking"
        case .hockey:                       return "figure.hockey"
        case .hunting:                      return "figure.hunting"
        case .lacrosse:                     return "figure.lacrosse"
        case .martialArts:                  return "figure.martial.arts"
        case .mindAndBody:                  return "figure.mind.and.body"
        case .mixedMetabolicCardioTraining: return "figure.mixed.cardio"
        case .paddleSports:                 return "figure.rowing"
        case .play:                         return "figure.play"
        case .preparationAndRecovery:       return "figure.cooldown"
        case .racquetball:                  return "figure.racquetball"
        case .rowing:                       return "figure.rowing"
        case .rugby:                        return "figure.rugby"
        case .running:                      return "figure.run"
        case .sailing:                      return "figure.sailing"
        case .skatingSports:                return "figure.skating"
        case .snowSports:                   return "figure.skiing"
        case .soccer:                       return "figure.soccer"
        case .softball:                     return "figure.softball"
        case .squash:                       return "figure.squash"
        case .stairClimbing:                return "figure.stairs"
        case .surfingSports:                return "figure.surfing"
        case .swimming:                     return "figure.pool.swim"
        case .tableTennis:                  return "figure.table.tennis"
        case .tennis:                       return "figure.tennis"
        case .trackAndField:                return "figure.track.and.field"
        case .traditionalStrengthTraining:  return "figure.strengthtraining.traditional"
        case .volleyball:                   return "figure.volleyball"
        case .walking:                      return "figure.walk"
        case .waterFitness:                 return "figure.water.fitness"
        case .waterPolo:                    return "figure.water.polo"
        case .waterSports:                  return "figure.water.sports"
        case .wrestling:                    return "figure.wrestling"
        case .yoga:                         return "figure.yoga"
        
        // iOS 10
        case .barre:                        return "figure.barre"
        case .coreTraining:                return "figure.core.training"
        case .crossCountrySkiing:          return "figure.skiing.crosscountry"
        case .downhillSkiing:              return "figure.skiing.downhill"
        case .flexibility:                  return "figure.flexibility"
        case .highIntensityIntervalTraining: return "figure.hiit"
        case .jumpRope:                    return "figure.jumprope"
        case .kickboxing:                  return "figure.kickboxing"
        case .pilates:                     return "figure.pilates"
        case .snowboarding:                return "figure.snowboarding"
        case .stairs:                      return "figure.stairs"
        case .stepTraining:                return "figure.step.training"
        case .wheelchairWalkPace:          return "figure.roll"
        case .wheelchairRunPace:           return "figure.roll.runningpace"
        
        // iOS 11
        case .taiChi:                      return "figure.taichi"
        case .mixedCardio:                 return "figure.mixed.cardio"
        case .handCycling:                 return "figure.hand.cycling"
        
        // iOS 13
        case .discSports:                  return "figure.disc.sports"
        case .fitnessGaming:               return "gamecontroller"
        
        // Catch-all
        default:                           return "figure.walk"
        }
        return symbolName
    }
    
    var randomColor: Color {
        let defaultColor = Color.black
        switch self {
       case .americanFootball:             return .orange
       case .archery:                      return .green
       case .australianFootball:           return .red
       case .badminton:                    return .blue
       case .baseball:                     return .red
       case .basketball:                   return .orange
       case .bowling:                      return .brown
       case .boxing:                       return .red
       case .climbing:                     return .gray
       case .crossTraining:                return .purple
       case .curling:                      return .blue
       case .cycling:                      return .green
       case .dance:                        return .pink
       case .danceInspiredTraining:        return .purple
       case .elliptical:                   return .orange
       case .equestrianSports:            return .brown
       case .fencing:                      return .gray
       case .fishing:                      return .blue
       case .functionalStrengthTraining:   return .purple
       case .golf:                         return .green
       case .gymnastics:                   return .red
       case .handball:                     return .orange
       case .hiking:                       return .green
       case .hockey:                       return .blue
       case .hunting:                      return .brown
       case .lacrosse:                     return .purple
       case .martialArts:                  return .red
       case .mindAndBody:                  return .mint
       case .mixedMetabolicCardioTraining: return .orange
       case .paddleSports:                return .blue
       case .play:                        return .yellow
       case .preparationAndRecovery:      return .mint
       case .racquetball:                 return .blue
       case .rowing:                      return .blue
       case .rugby:                       return .green
       case .running:                     return .red
       case .sailing:                     return .blue
       case .skatingSports:               return .cyan
       case .snowSports:                  return .cyan
       case .soccer:                      return .green
       case .softball:                    return .red
       case .squash:                      return .orange
       case .stairClimbing:               return .purple
       case .surfingSports:               return .blue
       case .swimming:                    return .cyan
       case .tableTennis:                 return .green
       case .tennis:                      return .yellow
       case .trackAndField:               return .orange
       case .traditionalStrengthTraining: return .purple
       case .volleyball:                  return .yellow
       case .walking:                     return .green
       case .waterFitness:                return .blue
       case .waterPolo:                   return .cyan
       case .waterSports:                 return .blue
       case .wrestling:                   return .red
       case .yoga:                        return .mint
       
       // iOS 10
       case .barre:                       return .pink
       case .coreTraining:                return .purple
       case .crossCountrySkiing:          return .cyan
       case .downhillSkiing:              return .blue
       case .flexibility:                 return .mint
       case .highIntensityIntervalTraining: return .red
       case .jumpRope:                    return .orange
       case .kickboxing:                  return .red
       case .pilates:                     return .mint
       case .snowboarding:                return .cyan
       case .stairs:                      return .purple
       case .stepTraining:                return .orange
       case .wheelchairWalkPace:          return .blue
       case .wheelchairRunPace:           return .red
       
       // iOS 11
       case .taiChi:                      return .mint
       case .mixedCardio:                 return .orange
       case .handCycling:                 return .green
       
       // iOS 13
       case .discSports:                  return .orange
       case .fitnessGaming:               return .purple
       
       // Catch-all
        default:                           return defaultColor
       }
    }

}
