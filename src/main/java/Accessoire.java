package com.projet.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;

import java.io.Serializable;
import java.math.BigDecimal;

@Entity
@Table(name = "accessoires")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Accessoire implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Le nom est obligatoire")
    @Size(min = 2, max = 200, message = "Le nom doit contenir entre 2 et 200 caractères")
    @Column(nullable = false)
    private String nom;

    @NotNull(message = "Le prix est obligatoire")
    @DecimalMin(value = "0.0", inclusive = false, message = "Le prix doit être positif")
    @Digits(integer = 8, fraction = 2, message = "Format de prix invalide")
    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal prix;

    @NotNull(message = "Le stock est obligatoire")
    @Min(value = 0, message = "Le stock ne peut pas être négatif")
    @Column(nullable = false)
    private Integer stock;

    // Type : "Coque", "Chargeur", "Écouteurs", "Câble", "Verre trempé", etc.
    @NotBlank(message = "Le type est obligatoire")
    @Column(nullable = false)
    private String type;

    @Size(max = 1000)
    @Column(length = 1000)
    private String description;

    // URL de l'image du produit
    @Column(name = "image_url")
    private String imageUrl;

    @Column(name = "reference", unique = true)
    private String reference;

    // ─── Relations ──────────────────────────────────────────────────────────────

    // Plusieurs accessoires appartiennent à UNE marque
    // EAGER = la marque est chargée automatiquement avec l'accessoire
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "marque_id", nullable = false)
    @NotNull(message = "La marque est obligatoire")
    private Marque marque;

    // Plusieurs accessoires appartiennent à UNE catégorie
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "categorie_id", nullable = false)
    @NotNull(message = "La catégorie est obligatoire")
    private Categorie categorie;
}