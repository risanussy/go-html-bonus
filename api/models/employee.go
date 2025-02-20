package models

import "gorm.io/gorm"

type Employee struct {
	gorm.Model
	Name     string `json:"name"`
	Gaji     int64  `json:"gaji"`
	Email    string `json:"email" gorm:"unique"`
	Password string `json:"password"` // Simpan hash password
	Role     string `json:"role"`     // Contoh: admin, HRD, manager, pegawai
}
