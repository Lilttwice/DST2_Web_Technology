package cn.edu.zju.dao;

import cn.edu.zju.dbutils.DBUtils;
import cn.edu.zju.dto.DrugGeneAssociation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * ICA3 Module 2 — JDBC access for {@code drug} + {@code gene} + {@code drug_gene}.
 * <p>
 * Report: fuzzy match uses SQL {@code LIKE} with bound parameters (no string concatenation
 * into SQL text → mitigates SQL injection). Pagination uses {@code LIMIT}/{@code OFFSET}
 * on the server.
 */
public class DrugGeneSearchDao {

    private static final Logger log = LoggerFactory.getLogger(DrugGeneSearchDao.class);

    private static final String SELECT_BASE =
            "SELECT d.id, d.name, d.obj_cls, d.drug_url, g.id, g.name, "
                    + "IFNULL(g.description,''), IFNULL(dg.interaction_desc,'') "
                    + "FROM drug_gene dg "
                    + "JOIN drug d ON d.id = dg.drug_id "
                    + "JOIN gene g ON g.id = dg.gene_id ";

    public List<DrugGeneAssociation> searchByKeyword(String keyword, int page, int pageSize) {
        List<DrugGeneAssociation> out = new ArrayList<>();
        final String pattern = buildLikePattern(keyword);
        final int safePage = Math.max(1, page);
        final int safeSize = Math.max(1, Math.min(100, pageSize));
        final int offset = (safePage - 1) * safeSize;

        DBUtils.execSQL(connection -> {
            try {
                String sql = SELECT_BASE
                        + "WHERE LOWER(d.name) LIKE LOWER(?) OR LOWER(g.name) LIKE LOWER(?) "
                        + "ORDER BY d.name, g.name LIMIT ? OFFSET ?";
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setString(1, pattern);
                ps.setString(2, pattern);
                ps.setInt(3, safeSize);
                ps.setInt(4, offset);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    out.add(mapRow(rs));
                }
            } catch (SQLException e) {
                log.warn("searchByKeyword failed", e);
            }
        });
        return out;
    }

    public int countByKeyword(String keyword) {
        final int[] total = {0};
        final String pattern = buildLikePattern(keyword);
        DBUtils.execSQL(connection -> {
            try {
                String sql = "SELECT COUNT(*) FROM drug_gene dg "
                        + "JOIN drug d ON d.id = dg.drug_id "
                        + "JOIN gene g ON g.id = dg.gene_id "
                        + "WHERE LOWER(d.name) LIKE LOWER(?) OR LOWER(g.name) LIKE LOWER(?)";
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setString(1, pattern);
                ps.setString(2, pattern);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    total[0] = rs.getInt(1);
                }
            } catch (SQLException e) {
                log.warn("countByKeyword failed", e);
            }
        });
        return total[0];
    }

    /**
     * One association row for a given drug id + gene id (e.g. for Module 3 risk logic).
     */
    public DrugGeneAssociation findByDrugAndGene(String drugId, String geneId) {
        final DrugGeneAssociation[] holder = {null};
        DBUtils.execSQL(connection -> {
            try {
                String sql = SELECT_BASE + "WHERE d.id = ? AND g.id = ?";
                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setString(1, drugId);
                ps.setString(2, geneId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    holder[0] = mapRow(rs);
                }
            } catch (SQLException e) {
                log.warn("findByDrugAndGene failed", e);
            }
        });
        return holder[0];
    }

    private static String buildLikePattern(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return "%";
        }
        return "%" + keyword.trim() + "%";
    }

    private static DrugGeneAssociation mapRow(ResultSet rs) throws SQLException {
        return new DrugGeneAssociation(
                rs.getString(1),
                rs.getString(2),
                rs.getString(3),
                rs.getString(4),
                rs.getString(5),
                rs.getString(6),
                rs.getString(7),
                rs.getString(8));
    }
}
