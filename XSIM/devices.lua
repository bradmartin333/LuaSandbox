local base = require 'knife.base'

local A = {5, 5}
local B = {20, 28}
local C = {3, 2}

Device = base:extend()
function Device:constructor (x, y, w, h, RR, RC, R, C, IDX, WID, Sel)
  self.x = x
  self.y = y
  self.w = w
  self.h = h
  self.RR = RR
  self.RC = RC
  self.R = R
  self.C = C
  self.IDX = IDX
  self.WID = WID
  self.Sel = Sel
end

Devices = {}
function generateDevices()
  for n=1, C[2] do
    for m=1, C[1] do
      for l=1, B[2] do
        for k=1, B[1] do
          local idx = 1
          for j=1, A[2] do
            for i=1, A[1] do
              table.insert(Devices, Device(i*2+k*2+m*100,
                                           j*2+l*2+n*100,
                                           8, 8, m, n, k, l, idx, "ABC", false))
              idx = idx + 1
            end
          end
        end
      end
    end
  end
end